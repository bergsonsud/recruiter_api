# spec/integration/jobs_spec.rb
require 'swagger_helper'

RSpec.describe 'recruiters/jobs', type: :request do
  let(:recruiter) { create(:recruiter) }

  path '/v1/recruiters/jobs' do
    get('list jobs') do
      tags 'Recruiters > Jobs'
      produces 'application/json'
      parameter name: :Authorization, in: :header, type: :string

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

    post('create job') do
      tags 'Recruiters > Jobs'
      consumes 'application/json'
      parameter name: :Authorization, in: :header, type: :string
      parameter name: :job, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          description: { type: :string },
          start_date: { type: :string, format: :date },
          end_date: { type: :string, format: :date },
          status: { type: :string },
          skills: { type: :string },
          recruiter_id: { type: :integer }
        },
        required: %w[title description recruiter_id]
      }

      response(201, 'created') do
        let(:job) { { title: 'New Job', description: 'Job description', recruiter_id: recruiter.id } }
        let(:Authorization) { headers['Authorization'] }
        run_test!
      end

      response(422, 'unprocessable entity') do
        let(:job) { { title: nil } }
        let(:Authorization) { headers['Authorization'] }
        run_test!
      end
    end
  end

  path '/v1/recruiters/jobs/{id}' do
    parameter name: 'id', in: :path, type: :integer, description: 'id'
    let(:job) { create(:job, recruiter: recruiter) }

    get('show job') do
      tags 'Recruiters > Jobs'
      produces 'application/json'
      parameter name: :Authorization, in: :header, type: :string

      response(200, 'successful') do
        let(:id) { job.id }
        let(:Authorization) { headers['Authorization'] }
        run_test!
      end
    end

    put('update job') do
      tags 'Recruiters > Jobs'
      consumes 'application/json'
      parameter name: :Authorization, in: :header, type: :string
      parameter name: :job, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          description: { type: :string },
          start_date: { type: :string, format: :date },
          end_date: { type: :string, format: :date },
          status: { type: :string },
          skills: { type: :string },
          recruiter_id: { type: :integer }
        },
        required: %w[title description recruiter_id]
      }

      response(200, 'successful') do
        let(:id) { job.id }
        let(:job) { { title: 'Updated Title' } }
        let(:Authorization) { headers['Authorization'] }
        run_test!
      end

      response(422, 'unprocessable entity') do
        let(:id) { job.id }
        let(:job) { { title: nil } }
        let(:Authorization) { headers['Authorization'] }
        run_test!
      end
    end

    delete('delete job') do
      tags 'Recruiters > Jobs'
      parameter name: :Authorization, in: :header, type: :string

      response(204, 'successful') do
        let(:id) { job.id }
        let(:Authorization) { headers['Authorization'] }
        run_test!
      end
    end
  end
end
