require "rails_helper"

RSpec.describe "Api::V1::Categories", type: :request do
  path "/api/v1/categories" do
    post "Create category" do
      tags "Categories"
      consumes "application/json"
      security [{ ApiKeyAuth: [] }]

      parameter name: "Authorization", in: :header, type: :string
      parameter name: :category, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string }
        },
        required: %w[name]
      }

      response "201", "category created" do
        let(:Authorization) { JvtCoder.encode("#{FactoryBot.create(:user).id}") }
        let(:category) {{ name: "category#{rand(100000)}" }}
        run_test!
      end

      response "422", "invalid request" do
        let(:Authorization) { JvtCoder.encode("#{FactoryBot.create(:user).id}") }
        let(:category) { { name: "" } }
        run_test!
      end
    end
  end

  path "/api/v1/categories/{id}" do
    patch "Update category" do
      tags "Categories"
      consumes "application/json"
      security [{ ApiKeyAuth: [] }]

      parameter name: "Authorization", in: :header, type: :string
      parameter name: :id, in: :path, type: :integer, required: true
      parameter name: :category, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string }
        },
        required: %w[name],
      }

      response "200", "category updated" do
        let(:Authorization) { JvtCoder.encode("#{FactoryBot.create(:user).id}") }
        let(:current_category) { FactoryBot.create(:category) }
        let(:id) { current_category.id }
        let!(:category) { { name: "TestCategory" } }
        run_test!
      end

      response "422", "invalid request" do
        let(:Authorization) { JvtCoder.encode("#{FactoryBot.create(:user).id}") }
        let(:current_category) { FactoryBot.create(:category) }
        let(:id) { current_category.id }
        let(:category) { { name: "" } }
        run_test!
      end
    end

    delete "Delete category" do
      tags "Categories"
      consumes "application/json"
      security [{ ApiKeyAuth: [] }]

      parameter name: "Authorization", in: :header, type: :string
      parameter name: :id, in: :path, type: :integer, required: true

      response "204", :no_content do
        let(:Authorization) { JvtCoder.encode("#{FactoryBot.create(:user).id}") }
        let(:category) { FactoryBot.create(:category) }
        let(:id) { category.id }
        run_test!
      end
    end
  end
end
