require 'swagger_helper'

describe 'POSTS' do
  path '/api/v1/posts' do
    get 'List of posts' do
      tags 'Posts'
      consumes 'application/json'

      response 200, 'list of teams shown' do
        schema type: :object,
               properties: {
                 collection: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       id: { type: :integer },
                       user_id: { type: :integer },
                       title: { type: :string },
                       body: { type: :string },
                       category_id: { type: :integer },
                     }
                   }
                 }
               }
        run_test!
      end
    end

    post 'Create post' do
      tags 'Posts'
      consumes 'application/json'
      security [token: {}]


      parameter name: :'Authorization', in: :header, type: :string

      parameter name: :post, in: :body, schema: {
        type: :object,
        properties: {
          category_id: { type: :integer },
          title: { type: :string },
          body: { type: :string },
        },
        required: %w[title body]
      }

      response '200', 'return post' do
        user = FactoryBot.create(:user)
        post = FactoryBot.create(:post)
        token = JvtCoder.encode({ user_id: user.id })

        let(:'Authorization') { token }
        let(:post) { post }
        run_test!
      end
      response '422', 'invalid request' do
        run_test!
      end
    end
  end

  # path '/teams/{id}' do
  #   get 'Retrieve the team' do
  #     tags 'Teams'
  #     consumes 'application/json'
  #     security [
  #                { ApiKeyAuth: [] }
  #              ]
  #
  #     parameter name: :id, in: :path, required: true
  #
  #     response '200', 'team found' do
  #       run_test!
  #     end
  #
  #     response '404', 'team not found' do
  #       run_test!
  #     end
  #   end
    #
    # patch 'Update the team' do
    #   tags 'Teams'
    #   consumes 'application/json'
    #   security [
    #              { ApiKeyAuth: [] }
    #            ]
    #
    #   parameter name: :id, in: :path, type: :integer, required: true
    #   parameter name: :team, in: :body, schema: {
    #     type: :object,
    #     properties: {
    #       company_office_id: { type: :integer },
    #       title: { type: :string },
    #       team_lead_id: { type: :integer },
    #       rating: { type: :integer }
    #     },
    #     required: ['company_id', 'title'],
    #   }
    #
    #   response '201', 'team updated' do
    #     run_test!
    #   end
    #
    #   response '422', 'invalid request' do
    #     run_test!
    #   end
    # end

    # delete 'Delete team' do
    #   tags 'Teams'
    #   consumes 'application/json'
    #   security [
    #              { ApiKeyAuth: [] }
    #            ]
    #
    #   parameter name: :id, in: :path, type: :integer
    #
    #   response '204', :no_content do
    #     run_test!
    #   end
    #
    #   response '404', :not_found do
    #     run_test!
    #   end
    # end
  # end
end