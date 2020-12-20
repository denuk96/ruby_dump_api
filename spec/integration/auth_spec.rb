require "swagger_helper"

describe "Authorization API" do
  path "/api/v1/auth/sign-up" do
    post "creates User" do
      tags "Authorization"
      consumes "application/json"

      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[email password]
      }

      response "200", "Creates user" do
        let(:user) { { email: "user-#{rand(30000)}@factory.com", password: "qweqwe123" } }
        run_test!
      end

      response "409", "doesnt create" do
        let(:user) { "" }
        run_test!
      end
    end
  end

  path "/api/v1/auth/sign-in" do
    post "Login user" do
      tags "Authorization"
      consumes "application/json"

      parameter name: :user, in: :body, schema: {
          type: :object,
          properties: {
            email: { type: :string },
            password: { type: :string }
          },
          required: %w[email password]
      }

      response "200", "sign in user" do
        user = FactoryBot.create(:user)
        let(:user) { { email: user.email, password: "123456" } }
        run_test!
      end

      response "401", "doesnt create" do
        user = FactoryBot.create(:user)
        let(:user) { { email: user.email, password: "invalid_password" } }
        run_test!
      end
    end
  end

  path "/api/v1/auth/auto-login" do
    get "auto login" do
      tags "Authorization"
      consumes "application/json"
      parameter name: "Authorization", in: :header, type: :string

      response "200", "return user" do
        let(:Authorization) { JvtCoder.encode("#{FactoryBot.create(:user).id}") }
        run_test!
      end

      response "401", "doesnt create" do
        let(:'Authorization') { "" }
        run_test!
      end
    end
  end
end
