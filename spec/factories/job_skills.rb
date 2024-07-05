# frozen_string_literal: true

FactoryBot.define do
  factory :job_skill do
    association :job
    skill { Faker::Job.field }
  end
end
