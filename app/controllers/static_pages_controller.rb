class StaticPagesController < ApplicationController
  def home
    return unless logged_in?

    @micropost = current_user.microposts.build
    @pagy, @feed_items = pagy User.feed(merge_id)
  end

  def help; end

  def contact; end
end
