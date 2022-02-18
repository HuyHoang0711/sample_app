module MicropostsHelper
  def display_or_no_image micropost
    if micropost.image.attached?
      micropost.display_image
    else
      "no_image"
    end
  end
end
