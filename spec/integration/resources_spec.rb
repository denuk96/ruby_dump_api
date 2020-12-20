require "swagger_helper"

RSpec.describe "Api::V1::Resources", type: :request do
  path "/api/v1/first-load-resources" do
    get "Index posts " do
      tags "First Load resources"
      consumes "application/json"

      response 200, "All resources" do
        before do
          5.times do
            FactoryBot.create(:post)
            FactoryBot.create(:category)
          end
        end
        run_test!
      end
    end
  end
end