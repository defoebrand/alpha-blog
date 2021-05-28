module ApplicationHelper
  def avatar_img(size)
    image_tag('angry_squirrel.jpg', alt: 'avatar image', class: 'rounded mx-auto d-block img-fluid', style: "max-width: #{size}px !important;")
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end
end
