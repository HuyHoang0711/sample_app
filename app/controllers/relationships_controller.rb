class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :load_user, only: :create
  before_action :load_user_destroy, only: :destroy

  def create
    current_user.follow(@user)
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end

  def destroy
    current_user.unfollow(@user.followed)
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end

  private

  def load_user
    @user = User.find_by id: params[:followed_id]
    return if @user

    back_to_root
  end

  def load_user_destroy
    @user = Relationship.find_by(id: params[:id])
    return if @user

    back_to_root
  end

  def back_to_root
    flash[:danger] = t("has_no_user")
    redirect_to root_path
  end
end
