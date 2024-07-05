# frozen_string_literal: true

FactoryBot.define do
  factory :job do
    title { Faker::Job.title }
    description { Faker::Job.field }
    association :recruiter
    status { "active" }
  end

  factory :job_with_skills, parent: :job do
    transient do
      skills_count { 5 }
    end

    after(:create) do |job, evaluator|
      create_list(:job_skill, evaluator.skills_count, job: job)
    end
  end
end
