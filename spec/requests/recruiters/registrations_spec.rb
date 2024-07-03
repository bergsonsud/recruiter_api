# frozen_string_literal: true

require "rails_helper"

RSpec.describe("Recruiters::Registrations", type: :request) do
  describe "POST /recruiters" do
    let(:valid_params) do
      {
        email: "person1@mail.com",
        name: "Person 1",
        password: "password",
      }
    end

    let(:invalid_params) do
      {
        email: "",
        name: "",
        password: "",
      }
    end

    context "with valid params" do
      it "creates a new recruiter" do
        post "/recruiters", params: valid_params, headers: json_headers
        expect(response).to(have_http_status(:ok))
      end
    end

    context "with invalid params" do
      it "does not create a new recruiter" do
        post "/recruiters", params: invalid_params, headers: json_headers
        expect(response).to(have_http_status(:unprocessable_entity))
      end
    end
  end

  describe "POST /recruiters/sign_in" do
    let(:recruiter) { create(:recruiter) }

    context "with valid params" do
      it "signs in the recruiter" do
        post "/recruiters/sign_in",
          params: { email: recruiter.email, password: recruiter.password },
          headers: json_headers
        expect(response).to(have_http_status(:ok))
      end
    end

    context "with invalid params" do
      it "does not sign in the recruiter" do
        post "/recruiters/sign_in", params: { email: recruiter.email, password: "invalid" }, headers: json_headers
        expect(response).to(have_http_status(:unauthorized))
      end
    end
  end

  describe "DELETE /recruiters/sign_out" do
    let(:recruiter) { create(:recruiter) }

    context "with valid params" do
      it "signs out the recruiter" do
        headers = json_headers
        post "/recruiters/sign_in", params: { email: recruiter.email, password: recruiter.password }, headers: headers
        headers["Authorization"] = response.headers["Authorization"]
        delete "/recruiters/sign_out", headers: headers
        expect(response).to(have_http_status(:ok))
      end
    end
  end
end
