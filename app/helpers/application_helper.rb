module ApplicationHelper
  def avatar_img
    content_tag(:div, image_tag('angry_squirrel.jpg', alt: 'avatar image', class: 'rounded mx-auto d-block img-fluid'), class: 'container avatar_icon justify-content-center p0')
  end
end
