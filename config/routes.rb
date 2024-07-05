# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :v1 do
    namespace :recruiters, defaults: { format: :json } do
      mount_devise_token_auth_for "Recruiter", at: "/"
      resources :jobs
      resources :submissions, expect: %i[create]
    end
    resources :submissions, only: %i[create]
    resources :jobs, only: %i[index show]
  end
end
