# frozen_string_literal: true

require "rails_helper"

RSpec.describe(Job, type: :model) do
  describe "#relations" do
    it { is_expected.to(belong_to(:recruiter)) }

    it { is_expected.to(validate_presence_of(:title)) }
    it { is_expected.to(validate_presence_of(:description)) }
    it { is_expected.to(validate_presence_of(:recruiter_id)) }

    it { is_expected.to(define_enum_for(:status).with_values(active: 0, inactive: 1)) }
  end

  describe "#validations" do
    let(:job) { create(:job) }

    it "is valid with valid attributes" do
      expect(job).to(be_valid)
    end

    it "is not valid without a title" do
      job.title = nil
      expect(job).to(be_invalid)
    end

    it "is not valid without a description" do
      job.description = nil
      expect(job).to(be_invalid)
    end

    it "is not valid without a recruiter_id" do
      job.recruiter_id = nil
      expect(job).to(be_invalid)
    end

    it "valid job" do
      job.status = "active"
      expect(job).to(be_valid)
    end
  end

  describe "#scopes" do
    let(:recruiter) { create(:recruiter) }
    let(:recruiter2) { create(:recruiter) }
    let(:skill) { create(:job_skill, skill: "ruby") }
    let(:skill2) { create(:job_skill, skill: "css") }
    let(:skill3) { create(:job_skill, skill: "node") }
    let!(:job1) do
      create(
        :job,
        title: "Full Stack Developer",
        description: "We are looking for a Full Stack Developer",
        recruiter: recruiter,
        skills: [skill, skill2],
      )
    end
    let!(:job2) do
      create(
        :job,
        title: "Frontend Developer",
        description: "We are looking for a Frontend Developer",
        recruiter: recruiter,
        status: "inactive",
      )
    end
    let!(:job3) do
      create(
        :job,
        title: "Backend Developer",
        description: "We are looking for a Backend Developer",
        recruiter: recruiter2,
        skills: [skill3],
      )
    end

    it "by_recruiter_id" do
      expect(described_class.by_recruiter_id(recruiter.id)).to(include(job1, job2))
      expect(described_class.by_recruiter_id(recruiter2.id)).to(include(job3))
    end

    it "only_actives" do
      expect(described_class.only_actives).to(include(job1, job3))
    end

    it "search" do
      expect(described_class.search("Full Stack")).to(include(job1))
      expect(described_class.search("Backend")).to(include(job3))
      expect(described_class.search("Frontend")).to(include(job2))
      expect(described_class.search("ruby")).to(include(job1))
      expect(described_class.search("node")).to(include(job3))
      expect(described_class.search("css")).to(include(job1))
      expect(described_class.search("developer")).to(include(job1, job2, job3))
    end
  end
end
