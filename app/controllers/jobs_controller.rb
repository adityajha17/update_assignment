class JobsController < ApplicationController
  before_action :admin_authenticate, only: [:create_job,  :edit_job, :update_user_status]

  def available_job
     if admin_authenticate
      @job = Job.all
      @users = User.all
      @all_applied_jobs = Applystatus.select("job_id, user_id, status, id")
      render json: {
          jobs: @job
          # user: @users,
          # all_applied_jobs: @all_applied_jobs
      }
    else
      render json: { status: 500, info: "need an Admin Login" }
    end
  end

  def create_job

    @job = Job.new(job_params)
    if @job.save
      render json: { status: 200, info: "Job created" }
    else
      render json: { status: 500, errors: @job.errors }
    end

  end

    def edit_job

        @job = Job.find_by(id: params[:id])
        if @job.present?
          if @job.update(update_job_status)
            render json: { status: 200, info: :status_changed, job: @job }
          else
            render json: { status: 500, info: "Validation errors" }
          end
        else
          render json: { status: 500, info: "Job does not exist" }
        end
    end

    def update_user_status
        @usr = Applystatus.find_by(job_id: params[:job_id], user_id: @user)
        puts "errors", @usr
        if @usr.present?
          if @usr.update(user_job_status)
            @status = Applystatus.find_by(job_id: params[:job_id], user_id: @user)
            if @status.status == true
              render json: { status: 200,  info: "User Selected, Email sent." }
            else
              render json: { status: 200,  info: :status_changed }
            end
          else
            render json: { status: 500 }
          end
        else
          render json: { status: 500,  info: "No available job(s) for this User" }
        end

    end

    private

    def job_params
      params.permit(:title, :description, :category, :exp, :status)
    end

    def update_job_status
      params.permit(:status)
    end

    def user_job_status
      params.permit(:status)
    end
end