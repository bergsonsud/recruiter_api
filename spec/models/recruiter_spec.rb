# frozen_string_literal: true

require "rails_helper"

RSpec.describe(Recruiter, type: :model) do
  it { is_expected.to(validate_presence_of(:email)) }
  it { is_expected.to(validate_presence_of(:password)) }
  it { is_expected.to(validate_presence_of(:name)) }
end
