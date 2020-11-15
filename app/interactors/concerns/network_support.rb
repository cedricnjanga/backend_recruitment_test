module NetworkSupport
  extend ActiveSupport::Concern

  included do
    before :check_network
  end

  private

  def check_network
    if !network
      context.data = {
        errors: ["Network is required"]
      }

      context.fail!
    end
  end
end