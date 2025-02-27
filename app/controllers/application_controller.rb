# frozen_string_literal: true

class ApplicationController < ActionController::API
  include SimpleErrorRenderable
  self.simple_error_partial = "shared/simple_error"

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :password_confirmation])
  end
end
