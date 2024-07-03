# frozen_string_literal: true

class Recruiter < ApplicationRecord
  devise :database_authenticatable,
    :registerable,
    :recoverable,
    :rememberable,
    :validatable
  include DeviseTokenAuth::Concerns::User

  validates :name, presence: true
end
