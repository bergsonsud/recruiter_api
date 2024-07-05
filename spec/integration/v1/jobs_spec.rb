# spec/integration/jobs_spec.rb
require 'swagger_helper'

RSpec.describe 'public jobs', type: :request do
  path '/v1/jobs' do
    get('list jobs without parameters') do
      tags 'Public'
      produces 'application/json'

      response(200, 'successful') do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   title: { type: :string },
                   description: { type: :string },
                   start_date: { type: :string, format: :date },
                   end_date: { type: :string, format: :date },
                   status: { type: :string },
                   skills: { type: :string },
                   recruiter_id: { type: :integer }
                 },
                 required: %w[id title description recruiter_id]
               }

        run_test!
      end
    end

    get('list jobs with search parameter') do
      tags 'Public'
      produces 'application/json'
      parameter name: :search, in: :query, type: :string, description: 'Search query for title, description, or skills'

      response(200, 'successful') do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   title: { type: :string },
                   description: { type: :string },
                   start_date: { type: :string, format: :date },
                   end_date: { type: :string, format: :date },
                   status: { type: :string },
                   skills: { type: :string },
                   recruiter_id: { type: :integer }
                 },
                 required: %w[id title description recruiter_id]
               }

        let(:search) { 'engineer' }
        run_test!
      end
    end
  end

  path '/v1/jobs/{id}' do
    parameter name: 'id', in: :path, type: :integer, description: 'Job ID'
    let(:job) { create(:job) }

    get('show job') do
      tags 'Public'
      produces 'application/json'

      response(200, 'successful') do
        let(:id) { job.id }
        run_test!
      end
    end
  end
end
