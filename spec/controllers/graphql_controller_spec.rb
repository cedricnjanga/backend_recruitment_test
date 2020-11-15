require 'rails_helper'

RSpec.describe GraphqlController, type: :request do
  let(:network) { Network.create(name: "Paris") }
  let(:header_value) { Base64.encode64(network.name) }

  describe "#execute" do
    context "HTTP_X_NETWORK_NAME" do
      it "should return 403 if no header is provided" do
        post "/graphql", params: {
          query: "query{
            users{
              id
            }
          }"
        }

        expect(response.status).to eq(403)
      end

      it "should retyrb 400 if the header value is not valid" do
        post "/graphql",
        params: {
          query: "query{
            users{
              id
            }
          }"
        },
        headers: {
          'x-network-name': ''
        }

        expect(response.status).to eq(400)
      end

      it "should execute query if header value is right" do
        post "/graphql",
        params: {
          query: "query{
            users{
              id
            }
          }"
        },
        headers: {
          'x-network-name': header_value
        }

        expect(response.status).to eq(200)
      end
    end
  end
end