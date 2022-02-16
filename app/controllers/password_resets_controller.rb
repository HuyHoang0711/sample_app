class PasswordResetsController < ApplicationController
  before_action :load_user, :valid_user,
                :check_expiration, only: %i(edit update)

  def create
    @user = User.find_by email: params.dig(:password_reset, :email)&.downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t("reset_password_message")
      redirect_to root_url
    else
      flash.now[:danger] = t("email_not_found")
      render :new
    end
  end

  def new; end

  def edit; end

  def update
    if params.dig(:user, :password).blank?
      @user.errors.add :password, t("password_blank")
      render :edit
    elsif @user.update(user_params)
      log_in @user
      flash[:success] = t("update_password_success")
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def load_user
    @user = User.find_by email: params[:email]
    return if @user

    flash[:danger] = t("has_no_user")
    redirect_to root_path
  end

  def valid_user
    return if @user.activated && @user.authenticated?(:reset, params[:id])

    flash[:danger] = t("user_invalid")
    redirect_to root_url
  end

  def check_expiration
    return unless @user.password_reset_expired?

    flash[:danger] = t("password_expired")
    redirect_to new_password_reset_url
  end
end
