# frozen_string_literal: true

module V1
  module Recruiters
    class JobsController < V1::Recruiters::ApiController
      before_action :set_job, only: [:show, :update, :destroy]
      has_scope :by_recruiter_id, only: :index, allow_blank: true, default: true do |controller, scope, _|
        scope.by_recruiter_id(controller.current_v1_recruiters_recruiter.id)
      end

      # GET /jobs
      # GET /jobs.json
      def index
        @jobs = apply_scopes(Job).paginate(page: params[:page], per_page: 10)
      end

      # GET /jobs/1
      # GET /jobs/1.json
      def show
      end

      # POST /jobs
      # POST /jobs.json
      def create
        @job = Job.new(job_params)
        if @job.save
          render(:show, status: :ok)
        else
          render_error(fields: @job.errors.messages)
        end
      end

      # PATCH/PUT /jobs/1
      # PATCH/PUT /jobs/1.json
      def update
        if @job.update(job_params)
          render(:show, status: :ok)
        else
          render_error(fields: @job.errors.messages)
        end
      end

      # DELETE /jobs/1
      # DELETE /jobs/1.json
      def destroy
        nil if @job.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_job
        @job = Job.find(params[:id])
        if @job.recruiter_id != current_v1_recruiters_recruiter.id
          render_error(message: "Job not found", status: :not_found)
        end
      end

      # Only allow a list of trusted parameters through.
      def job_params
        params.require(:job).permit(
          :title,
          :description,
          :start_date,
          :end_date,
          :status,
          :recruiter_id,
          skills_attributes: [:id, :skill, :_destroy],
        )
      end
    end
  end
end
