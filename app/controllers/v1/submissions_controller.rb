# frozen_string_literal: true

module V1
  class SubmissionsController < ApplicationController
    # POST /submissions
    # POST /submissions.json
    def create
      @submission = Submission.new(submission_params)
      if @submission.save
        render(:show, status: :ok)
      else
        render_error(fields: @submission.errors.messages)
      end
    end

    # Only allow a list of trusted parameters through.
    def submission_params
      params.require(:submission).permit(:name, :email, :mobile_phone, :resume, :job_id)
    end
  end
end
