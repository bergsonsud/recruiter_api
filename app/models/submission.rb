# frozen_string_literal: true

class Submission < ApplicationRecord
  belongs_to :job

  validates :name, :email, :job_id, presence: true
  validates :email, uniqueness: { scope: :job_id }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
