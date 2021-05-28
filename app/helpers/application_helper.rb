module ApplicationHelper
  def avatar_img(size)
    image_tag('angry_squirrel.jpg', alt: 'avatar image', class: 'rounded mx-auto d-block img-fluid', style: "max-width: #{size}px !important;")
  end
end
