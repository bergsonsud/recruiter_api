# frozen_string_literal: true

require "rails_helper"

RSpec.describe(Submission, type: :model) do
  let!(:job) { create(:job) }

  it { is_expected.to(belong_to(:job)) }

  describe "Validations" do
    subject { described_class.new(name: "Name", email: "manoel@mail.com", job_id: job.id) }

    it { is_expected.to(validate_presence_of(:name)) }
    it { is_expected.to(validate_presence_of(:email)) }
    it { is_expected.to(validate_presence_of(:job_id)) }

    it { is_expected.to(validate_uniqueness_of(:email).scoped_to(:job_id)) }

    it "validates email format" do
      subject.email = "invalid_email"
      expect(subject).not_to(be_valid)
    end

    it "validates email format" do
      expect(subject).to(be_valid)
    end

    context "validate uniqueness of email" do
      let!(:submission) { create(:submission, email: "manoel@mail.com", job_id: job.id) }

      it "validates email uniqueness" do
        expect(subject).not_to(be_valid)
      end
    end
  end

  describe "Relations" do
    it { is_expected.to(belong_to(:job)) }
  end
end
