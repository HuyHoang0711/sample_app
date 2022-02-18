class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(create new show)
  before_action :load_user, except: %i(index create new)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def index
    @pagy, @users = pagy(User.all)
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t("message_mail")
      redirect_to root_url
    else
      flash.now[:danger] = t("failed")
      render :new
    end
  end

  def new
    @user = User.new
  end

  def edit; end

  def show
    @pagy, @microposts = pagy(@user.microposts)
  end

  def update
    if @user.update(user_params)
      flash[:success] = t("success_profile")
      redirect_to @user
    else
      flash.now[:danger] = t("failed_profile")
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t("user_deleted")
    else
      flash[:danger] = t("deleted_fail")
    end
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  def correct_user
    return if current_user?(@user)

    not_valid_user t("current_user")
  end

  def admin_user
    return if current_user.admin?

    not_valid_user t("admin")
  end

  def not_valid_user message
    flash[:danger] = message
    redirect_to root_url
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t("has_no_user")
    redirect_to root_path
  end
end
