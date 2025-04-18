class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: 'เข้าสู่ระบบสำเร็จ!'
    else
      flash.now[:alert] = 'อีเมลหรือรหัสผ่านไม่ถูกต้อง'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'ออกจากระบบสำเร็จ!'
  end
end 