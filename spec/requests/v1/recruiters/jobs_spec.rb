# frozen_string_literal: true

require "rails_helper"

RSpec.describe("Recruiters::Jobs", type: :request) do
  let(:recruiter) { create(:recruiter) }
  let(:recruiter2) { create(:recruiter) }

  describe "GET /recruiters/jobs" do
    context "with valid params" do
      it "gets the jobs" do
        get "/v1/recruiters/jobs", headers: auth_headers(recruiter)
        expect(response).to(have_http_status(:ok))
      end
    end

    context "with invalid params" do
      it "does not get the jobs" do
        get "/v1/recruiters/jobs", headers: json_headers
        expect(response).to(have_http_status(:unauthorized))
      end
    end

    context "with invalid owner" do
      it "does not get the jobs" do
        get "/v1/recruiters/jobs", headers: auth_headers(recruiter2)
        expect(response).to(have_http_status(:ok))
      end
    end
  end

  describe "POST /recruiters/jobs" do
    context "with valid params" do
      it "creates a job" do
        body = {
          title: "title",
          description: "description",
          recruiter_id: recruiter.id,
          start_date: Time.zone.today,
          end_date: Time.zone.today + 1,
          skills_attributes: [
            { skill: "skill1" },
            { skill: "skill2" },
          ],
        }
        post "/v1/recruiters/jobs", params: { job: body }, headers: auth_headers(recruiter)
        expect(response).to(have_http_status(:ok))
      end
    end

    context "with invalid params" do
      it "does not create a job" do
        body = {
          title: "title",
          description: "description",
        }
        post "/v1/recruiters/jobs", params: { job: body }, headers: auth_headers(recruiter)
        expect(response).to(have_http_status(:unprocessable_entity))
      end
    end
  end

  describe "PUT /recruiters/jobs/:id" do
    let(:job) { create(:job, recruiter: recruiter) }

    context "with valid params" do
      it "updates a job" do
        put "/v1/recruiters/jobs/#{job.id}",
          params: { job: { title: "new title", description: "new description" } },
          headers: auth_headers(recruiter)
        expect(response).to(have_http_status(:ok))
      end
    end

    context "with invalid params" do
      it "does not update a job" do
        put "/v1/recruiters/jobs/#{job.id}",
          params: { job: { title: "", description: "" } },
          headers: auth_headers(recruiter)
        expect(response).to(have_http_status(:unprocessable_entity))
      end
    end

    context "with invalid owner" do
      it "does not update a job" do
        put "/v1/recruiters/jobs/#{job.id}",
          params: { job: { title: "new title", description: "new description" } },
          headers: auth_headers(recruiter2)
        expect(response).to(have_http_status(:not_found))
      end
    end
  end

  describe "DELETE /recruiters/jobs/:id" do
    let(:job) { create(:job, recruiter: recruiter) }

    context "with valid params" do
      it "deletes a job" do
        delete "/v1/recruiters/jobs/#{job.id}", headers: auth_headers(recruiter)
        expect(response).to(have_http_status(:no_content))
      end
    end

    context "with invalid params" do
      it "does not delete a job" do
        delete "/v1/recruiters/jobs/#{job.id}", headers: json_headers
        expect(response).to(have_http_status(:unauthorized))
      end
    end

    context "with invalid owner" do
      it "does not delete a job" do
        delete "/v1/recruiters/jobs/#{job.id}", headers: auth_headers(recruiter2)
        expect(response).to(have_http_status(:not_found))
      end
    end
  end

  describe "GET /recruiters/jobs pagination" do
    let!(:jobs) { create_list(:job, 20, recruiter: recruiter) }

    it "gets the jobs" do
      get "/v1/recruiters/jobs", headers: auth_headers(recruiter)
      expect(response).to(have_http_status(:ok))
      expect(JSON.parse(response.body).length).to(eq(10))
    end
  end
end
