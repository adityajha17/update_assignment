class AdminsController < ApplicationController
 
  def generate_otp
    
      if params[:mobile].to_i > 6000000000 && params[:mobile].to_i < 9999999999
        @otp = rand(111111..999999)
        # puts @otp
        @number = params[:mobile]
        admin = Admin.new
        admin.otp = @otp
        admin.mobile = @number
        if admin.save
          render json: admin, status: :created
        else
          render json: { errors: admin.errors.full_messages },
                 status: :unprocessable_entity
        end
    else
      render json: {
          status: 500,
          info: "Enter correct mobile number"
      }
    end

  
  end




  def verify_otp
    admin = Admin.find_by(mobile: params[:mobile]) 
    puts admin.otp
    puts admin.mobile
    
      @otp2 = admin.otp
      puts @otp2

      params_otp = params[:otp].to_s

    if @otp2 == params[:otp].to_i
      @number1 =  admin.mobile
      @number = nil
      admin_secret_key = Rails.application.credentials.admin_secret_key
      token = JWT.encode({
                               admin_id: admin.id,
                               mobile: admin.mobile
                           }, admin_secret_key)
            render json: { token: token }
        
      
    else
      render json: {
          status: "Wrong OTP"
      }
    end

  end


  private

  def admin_params
    params.permit(:mobile, :otp)
  end
end



