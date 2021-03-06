class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  helper_method :current_order

  def current_order
    if user_signed_in? && session[:order_id].nil?
      order = Order.new
      order.user = current_user
      order
    else
      Order.find(session[:order_id])
    end
  end

end
