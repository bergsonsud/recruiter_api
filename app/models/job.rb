# frozen_string_literal: true

class Job < ApplicationRecord
  belongs_to :recruiter
  has_many :skills, class_name: "JobSkill", dependent: :destroy

  accepts_nested_attributes_for :skills, allow_destroy: true

  validates :title, :description, :recruiter_id, presence: true

  enum status: { active: 0, inactive: 1 }

  scope :by_recruiter_id, ->(recruiter_id) { where(recruiter_id: recruiter_id) }
  scope :only_actives, -> { where(status: :active) }
  scope :search, ->(query) { left_joins(:skills).where("jobs.title ILIKE ? OR jobs.description ILIKE ? OR job_skills.skill ILIKE ?", "%#{query}%", "%#{query}%", "%#{query}%").distinct }
end
