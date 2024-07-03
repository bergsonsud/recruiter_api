# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :recruiters, defaults: { format: :json } do
    mount_devise_token_auth_for "Recruiter", at: "/"
  end
end
