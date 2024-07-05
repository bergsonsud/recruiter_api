require 'swagger_helper'

RSpec.describe 'Submissions API', type: :request do
  path '/v1/submissions' do
    post 'Creates a submission' do
      tags 'Public'
      consumes 'application/json'
      parameter name: :submission, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          email: { type: :string },
          mobile_phone: { type: :string },
          resume: { type: :string },
          job_id: { type: :integer }
        },
        required: %w[name email job_id]
      }

      response '201', 'created' do
        let(:submission) { { name: 'John Doe', email: 'john.doe@example.com', job_id: 1 } }
        run_test!
      end

      response '422', 'unprocessable entity' do
        let(:submission) { { name: nil } }
        run_test!
      end
    end
  end
end
