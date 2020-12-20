require "rails_helper"

RSpec.describe "Api::V1::Posts", type: :request do
  path "/api/v1/posts" do
    get "Index posts " do
      tags "Posts"
      consumes "application/json"
      security [{ ApiKeyAuth: [] }]

      parameter name: "Authorization", in: :header, type: :string

      response 200, "All posts" do
        let(:Authorization) { JvtCoder.encode("#{FactoryBot.create(:user).id}") }
        before do
          5.times do
            FactoryBot.create(:post)
          end
        end
        run_test!
      end
    end

    post "Create post" do
      tags "Posts"
      consumes "application/json"
      security [{ ApiKeyAuth: [] }]

      parameter name: "Authorization", in: :header, type: :string
      parameter name: :post_params, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          body: { type: :string },
          user_id: { type: :integer }
        },
        required: %w[title body user_id]
      }

      response "201", "post created" do
        let(:user) { FactoryBot.create(:user) }
        let(:Authorization) { JvtCoder.encode("#{user.id}") }
        let(:post_params) { { title: "home#{rand(10000)}", body: "text ...", user_id: user.id } }
        run_test!
      end

      response "422", "invalid request" do
        let(:Authorization) { JvtCoder.encode("#{FactoryBot.create(:user).id}") }
        let(:post_params) { { title: "" } }
        run_test!
      end
    end
  end

  path "/api/v1/posts/{id}" do
    patch "Update post" do
      tags "Posts"
      consumes "application/json"
      security [{ ApiKeyAuth: [] }]

      parameter name: "Authorization", in: :header, type: :string
      parameter name: :id, in: :path, type: :integer, required: true
      parameter name: :post_params, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          body: { type: :string },
          user_id: { type: :integer }
        },
        required: %w[title body user_id]
      }

      response "200", "Post updated" do
        let(:Authorization) { JvtCoder.encode("#{FactoryBot.create(:user).id}") }
        let(:current_post) { FactoryBot.create(:post) }
        let(:id) { current_post.id }
        let(:post_params) { { title: "Test post" } }
        run_test!
      end

      response "422", "invalid request" do
        let(:Authorization) { JvtCoder.encode("#{FactoryBot.create(:user).id}") }
        let(:current_post) { FactoryBot.create(:post) }
        let(:id) { current_post.id }
        let(:post_params) { { title: "" } }
        run_test!
      end
    end

    delete "Delete post" do
      tags "Posts"
      consumes "application/json"
      security [{ ApiKeyAuth: [] }]

      parameter name: "Authorization", in: :header, type: :string
      parameter name: :id, in: :path, type: :integer, required: true

      response "204", :no_content do
        let(:Authorization) { JvtCoder.encode("#{FactoryBot.create(:user).id}") }
        let(:post) { FactoryBot.create(:post) }
        let(:id) { post.id }
        run_test!
      end
    end
  end
end
