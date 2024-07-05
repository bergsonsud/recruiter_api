# frozen_string_literal: true

require "rails_helper"

RSpec.describe("Jobs", type: :request) do
  let(:recruiter) { create(:recruiter) }
  let(:recruiter2) { create(:recruiter) }
  let(:job) { create(:job, recruiter: recruiter) }

  describe "GET /jobs" do
    context "with valid params" do
      it "gets the jobs" do
        get "/v1/jobs", headers: json_headers
        expect(response).to(have_http_status(:ok))
      end
    end
  end

  describe "GET /jobs pagination" do
    let!(:jobs) { create_list(:job, 20, recruiter: recruiter) }

    it "gets the jobs" do
      get "/v1/jobs", headers: json_headers
      expect(response).to(have_http_status(:ok))
      expect(JSON.parse(response.body).length).to(eq(10))
    end
  end

  describe "GET /jobs/:id" do
    context "with valid params" do
      it "gets a job" do
        get "/v1/jobs/#{job.id}", headers: json_headers
        expect(response).to(have_http_status(:ok))
      end
    end

    context "with invalid params" do
      it "does not get a job" do
        get "/v1/jobs/#{job.id}", headers: json_headers
        expect(response).to(have_http_status(:ok))
        expect(JSON.parse(response.body)["id"]).to(eq(job.id))
      end
    end
  end
end
