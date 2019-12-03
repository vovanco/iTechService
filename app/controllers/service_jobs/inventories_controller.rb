module ServiceJobs
  class InventoriesController < ApplicationController
    before_action :authorize

    def new
      @service_jobs = local_service_jobs

      respond_to do |format|
        format.html
      end
    end

    def show
      @service_jobs = local_service_jobs.where(id: LostDevice.pluck(:service_job_id))

      respond_to do |format|
        format.html
      end
    end

    def create
      found_job_ids = inventory_params[:found_job_ids]
      lost_job_ids = inventory_params[:job_ids].split - found_job_ids

      lost_job_ids.each do |job_id|
        LostDevice.find_or_create_by(service_job_id: job_id)
      end

      LostDevice.where(id: found_job_ids).delete_all
      @service_jobs = ServiceJob.where(id: lost_job_ids)
      render :new
    end

    private

    def inventory_params
      params[:inventory]
    end

    def authorize
      super ServiceJob, :inventory?
    end

    def local_service_jobs
      locations = department.locations.done
      ServiceJob.includes(:location).where(location: locations)
    end

    def department
      @department = params.key?(:department_id) ? Department.find(params[:department_id]) : Department.current
    end
  end
end
