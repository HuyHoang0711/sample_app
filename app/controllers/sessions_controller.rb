class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params.dig(:session, :email)&.downcase
    if user&.authenticate(params.dig(:session, :password))
      log_in user
      remember_or_forget user
      redirect_to user
    else
      flash.now[:danger] = t("log_in_failed")
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  def remember_or_forget user
    params[:session][:remember_me] == "1" ? remember(user) : forget(user)
  end
end
