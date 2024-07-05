# frozen_string_literal: true

FactoryBot.define do
  factory :submission do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    mobile_phone { Faker::PhoneNumber.cell_phone }
    association :job
  end
end
