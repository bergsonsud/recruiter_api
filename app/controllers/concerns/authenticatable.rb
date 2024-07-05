# frozen_string_literal: true

module Authenticatable
  extend ActiveSupport::Concern

  included do
    include DeviseTokenAuth::Concerns::SetUserByToken
    before_action :authenticate_v1_recruiters_recruiter!
  end
end
