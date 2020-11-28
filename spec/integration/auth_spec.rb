require 'swagger_helper'

describe 'Authorization API' do
  path '/api/v1/auth/sign-up' do
    post 'creates User' do
      tags 'Authorization'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[email password]
      }
      # parameter name: 'Authorization', in: :header, type: :string

      response '200', 'Creates user' do
        let(:user) { { email: 'email', password: 'bar' } }
        run_test!
      end

      response '409', 'doesnt create' do
        let(:user) { '' }
        run_test!
      end
    end
  end
end