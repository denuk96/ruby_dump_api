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

  path '/api/v1/auth/sign-in' do
    post 'Login user' do
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

      response '200', 'sign in user' do
        user = FactoryBot.create(:user)
        let(:user) { { email: user.email, password: '123456' } }
        run_test!
      end

      response '401', 'doesnt create' do
        user = FactoryBot.create(:user)
        let(:user) { { email: user.email, password: 'invalid_password' } }
        run_test!
      end
    end
  end

  path '/api/v1/auth/auto-login' do
    get 'auto login' do
      tags 'Authorization'
      consumes 'application/json'
      parameter name: 'Authorization', in: :header, type: :string

      response '200', 'return user' do
        user = FactoryBot.create(:user)
        token = JvtCoder.encode({ user_id: user.id })

        let(:'Authorization') { token }
        run_test!
      end

      response '401', 'doesnt create' do
        token = JvtCoder.encode({ user_id: 'invalid-token' })
        let(:'Authorization') { token }
        run_test!
      end
    end
  end
end