class HomeController < ApplicationController
  def index
    if admin_authenticate
      @jobs = Job.all
      @users = User.all
      @all_applied_jobs = Applystatus.select("job_id, user_id, status, id")
      render json: {
          jobs: @jobs,
          user: @users,
          all_applied_jobs: @all_applied_jobs
      }
      #for user login
    else
      if user_authenticate
      @jobs = Job.where(status: true)
      @applied_jobs = Applystatus.select("status").where(job_id: @jobs, user_id: @user)
      render json: {
          jobs: @jobs,
          applied_jobs: @applied_jobs
      }
      # for non-logged users
    else
      @jobs = Job.where(status: true)
      render json: {
          jobs: @jobs
      }
    end
  end
  end
  end
