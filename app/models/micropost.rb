class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  scope :recent_posts, ->{order(created_at: :desc)}

  validates :content, presence: true,
                      length: {maximum: Settings.content.character_140}
  validates :image, content_type: {in: Settings.image.format_valid,
                                   message: I18n.t("valid_format_image")},
                    size: {less_than: Settings.image.size_5.megabytes,
                           message: I18n.t("valid_size_image",
                                           count: Settings.image.size_5)}
  def display_image
    image.variant resize_to_limit: Settings.image.limit_size_500
  end
end
