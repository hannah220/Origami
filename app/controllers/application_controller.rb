class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :prepare_cart
  def prepare_cart
    @cart = session[:cart]
    @total_amount ||= 0
    unless @cart.nil? then
      @cart.each do |c|
        @total_amount += c["quantity"].to_i
        puts c["quantity"]
        puts c
      end
    end
    @price = session[:price]
  end
end
