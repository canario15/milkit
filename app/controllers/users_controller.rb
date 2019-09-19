class UsersController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to tambo_path }
      else
        format.html { render :edit }
      end
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :avatar)
    end

end