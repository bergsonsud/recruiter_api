# frozen_string_literal: true

require "rails_helper"

RSpec.describe("V1::Recruiters::Subs", type: :request) do
  let(:job) { create(:job) }

  let(:valid_body) do
    {
      job_id: job.id,
      name: "Manuel",
      email: "manuel@mail.com",
      mobile_phone: "99 988998899",
    }
  end

  let(:invalid_body) do
    {
      job_id: job.id,
      name: "Manuel",
      mobile_phone: "mobile_phone",
    }
  end

  describe "POST /submissions" do
    context "with valid params" do
      it "creates a submission" do
        post "/v1/submissions", params: { submission: valid_body }, headers: json_headers
        expect(response).to(have_http_status(:ok))
      end
    end

    context "with invalid params" do
      it "does not create a submission" do
        post "/v1/submissions", params: { submission: invalid_body }, headers: json_headers
        expect(response).to(have_http_status(:unprocessable_entity))
      end
    end

    context "with same email" do
      it "does not create a submission" do
        create(:submission, email: valid_body[:email], job_id: job.id)
        post "/v1/submissions", params: { submission: valid_body }, headers: json_headers
        expect(response).to(have_http_status(:unprocessable_entity))
      end
    end
  end
end
