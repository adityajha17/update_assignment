class AdminsController < ApplicationController
  def generate_otp
    if params[:mobile].to_i > 6000000000 && params[:mobile].to_i < 9999999999
      @@otp = rand(111111..999999)
      puts "OTP is #@@otp"
      @number = params[:mobile]
      puts "Mobile number is #@number"
      # puts "OTP1 is #@@otp1"
      render json: {
          status: :checked,
          otp: @@otp

      }
    else
      render json: {
          status: 500,
          info: "Enter correct mobile number"
      }
    end

  end



  def verify_otp
    puts "OTP1 is #@@otp"
      @otp2 = @@otp

      params_otp = params[:otp].to_s

    if @otp2 == params[:otp].to_i
      @number1 =  @number
      @number = nil
      @admin = Admin.new(admin_params)
      @admin.save

      admin = Admin.find_by(mobile: params[:mobile])
      if !admin
        render status: :unauthorized
      else
        secret_key = Rails.application.secrets.secret_key_base[0]
        token = JWT.encode({
                               admin_id: admin.id,
                               mobile: admin.mobile
                           }, secret_key)
        render json: { token: token }
      end
    else
      render json: {
          status: "Wrong OTP"
      }
    end

  end


  private

  def admin_params
    params.permit(:mobile, :otp, :role)
  end
end
