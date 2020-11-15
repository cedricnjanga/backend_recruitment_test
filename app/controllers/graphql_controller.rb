class GraphqlController < ApplicationController
  NETWORK_NAME_HEADER = 'HTTP_X_NETWORK_NAME'
  # If accessing from outside this domain, nullify the session
  # This allows for outside API access while preventing CSRF attacks,
  # but you'll have to authenticate your user separately
  # protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token

  before_action :set_current_netwotk

  def execute
    variables = ensure_hash(params[:variables])
    query = params.require(:query)
    operation_name = params[:operationName]
    context = {
      current_network: current_network
    }
    result = MyappSchema.execute(query, variables: variables, context: context, operation_name: operation_name, root_value: current_network)
    render json: result
  rescue => e
    raise e unless Rails.env.development?
    handle_error_in_development e
  end

  private

  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def handle_error_in_development(e)
    logger.error e.message
    logger.error e.backtrace.join("\n")

    render json: { errors: [{ message: e.message, backtrace: e.backtrace }], data: {} }, status: 500
  end

  def set_current_netwotk
    if !request.headers.include?(NETWORK_NAME_HEADER)
      return render json: { errors: ["HTTP_X_NETWORK_NAME header is required"]}, status: 403
    end

    network_name = Base64.decode64(request.headers[NETWORK_NAME_HEADER])

    network = Network.find_by_name(network_name)

    if !network
      return render json: { errors: ["No networks could be found with the provided name: #{network_name}"]}, status: 400
    end

    @current_network = network
  end

  def current_network
    @current_network
  end
end
