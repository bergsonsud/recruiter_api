# spec/integration/registrations_spec.rb
require 'swagger_helper'

RSpec.describe 'Registrations API', type: :request do
  path '/v1/recruiters/sign_up' do
    post('create a new account') do
      tags 'Recruiters > Registration'
      consumes 'application/json'
      parameter name: :registration, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string },
          password_confirmation: { type: :string }
        },
        required: %w[email password password_confirmation]
      }

      response(201, 'created') do
        let(:registration) { { email: 'user@example.com', password: 'password', password_confirmation: 'password' } }
        run_test!
      end

      response(422, 'unprocessable entity') do
        let(:registration) { { email: 'user@example.com', password: 'password', password_confirmation: 'wrong_password' } }
        run_test!
      end
    end
  end

  path '/v1/recruiters/sign_in' do
    post('sign in to the account') do
      tags 'Recruiters > Registration'
      consumes 'application/json'
      parameter name: :credentials, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[email password]
      }

      response(200, 'successful') do
        let(:user) { create(:user, email: 'user@example.com', password: 'password') }
        let(:credentials) { { email: 'user@example.com', password: 'password' } }
        run_test!
      end

      response(401, 'unauthorized') do
        let(:credentials) { { email: 'user@example.com', password: 'wrong_password' } }
        run_test!
      end
    end
  end
end
