# frozen_string_literal: true

module V1
  class JobsController < ApplicationController
    before_action :set_job, only: [:show]
    has_scope :only_actives, only: :index, default: true, type: :boolean
    has_scope :search, only: :index, allow_blank: true

    # GET /jobs
    # GET /jobs.json
    def index
      @jobs = apply_scopes(Job).paginate(page: params[:page], per_page: 10)
    end

    # GET /jobs/1
    # GET /jobs/1.json
    def show
    end

    private

    def set_job
      @job = Job.find(params[:id])
    end
  end
end
