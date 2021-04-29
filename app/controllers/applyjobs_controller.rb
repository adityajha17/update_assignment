class ApplyjobsController < ApplicationController
  before_action :user_authenticate, only: [:create]
  def index
    applyjobs = Applystatus.all
    render json: { applyjobs: applyjobs }
  end

  def create
    @job = Job.find_by(id: params[:job_id], status: true)
    if @job.present?
      @uids = Applystatus.where(user_id: @user)
      if @uids.find_by(job_id: params[:job_id])
        render json: {
            status: 200,
            info: "already applied"
        }
      else
        puts "ELSE"
            applystatus =  Applystatus.create(
                job_id: params[:job_id],
                user: @user,
                status: true
        )
        render json: { applystatus: applystatus }
      end
    else
      render json:{
          status: 500,
          info: "Job is inactive."
      }
    end

  end
end
