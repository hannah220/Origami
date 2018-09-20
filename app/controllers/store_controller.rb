class StoreController < ApplicationController
  RETURN_URL = "http://2eb90e34.ngrok.io/store/purchase"
  CANCEL_URL = "http://2eb90e34.ngrok.io/store/cancel"

  def index
    @categories = Category.all
  end

  def items
    @category = Category.find(params[:category_id])
    @title = @category.name
    @items = Item.where(:category_id => params[:category_id])
  end

  def item
    @item = Item.find(params[:id])
    @title = @item.name
  end

  def add_to_cart 
    session[:cart] = []
    session[:price] = 0

    @item = Item.find(params[:id])
    @quantity = params[:quantity]
    @size = params[:size]
    new_items = {item_id: params[:id], quantity: params[:quantity], size: params[:size]}
    flag = 0

    if (session[:cart].blank?) then
      puts "cart is blank"
      session[:cart] = []
      session[:cart] << new_items
    else 
      session[:cart].each do |c|
        if (c["item_id"] == params[:id] && c["size"] == params[:size]) then 
          puts "same item_id"
          c["quantity"] += params[:quantity] 
          flag = 1
        else 
          puts "not same item_id"
        end
      end
      if flag == 0 then
          session[:cart] << new_items
      end
    end

    session[:price] ||= BigDecimal("0")
    item_price = @item.price * (@quantity.to_d)
    session[:price] = item_price.to_d + session[:price].to_d

    flash[:notine] = "Added #{@item.name} in the cart"
    redirect_to store_items_path(:category_id => @item.category_id)
  end

  def prepare_menu
    @categories = Category.all
    @cart = session[:cart]
    @price = session[:price] || 0
  end

  def empty_cart
    session[:cart] = []
    session[:price] = 0
    #redirect_to params[:back_to]
  end

  def cart
    @items = Item.all
    @cart = session[:cart]
    @price = session[:price] || 0
  end

  def checkout
    @customer = Customer.new
    @shipping_addr = @customer.shipping_addr.build
  end

  def order
    customer = Customer.create(first_name: params[:customer][:first_name], last_name: params[:customer][:last_name])
    shipping_addr = ShippingAddr.create(street: params[:customer][:shipping_addr][:street], postal: params[:customer][:shipping_addr][:postal], zip: params[:customer][:shipping_addr][:zip], country: params[:customer][:shipping_addr][:country], customer_id: customer.id)

    order = Order.create(:customer => customer, :order_date => Time.now, :status => 'placed')
    @order_line = []
    @items = []
    session[:cart].each do |o|
      @order_line << order.order_line.create(:item_id => o["item_id"], :order_id => order.id, :item_amount => o["quantity"])
    end

    @order_line.each do |ol|
      puts "test"
      @items  << {
        :name => Item.find(ol.item_id).name,
        :quantity => ol.item_amount,
        #:price => Item.find(ol.item_id).price.to_s,
        :amount => Item.find(ol.item_id).price.to_i * 100
        #:currency => "EUR",
      }
      puts "the amount is"
      puts Item.find(ol.item_id).price.to_i * 100
    end

#    session[:cart] = []
#    session[:price] = 0
#    flash[:notice] = "Thank you for ordering"
#    redirect_to store_path
  end

  def paypal

    # Paypal payment
    payment = PayPal::SDK::REST::Payment.new({
      :intent => "sale",
      :payer => {
        :payment_method => "paypal"
      },
      :redirect_urls => {
        :return_url => "http://localhost/payment/execute",
        :cancel_url => "http://localhost:3000/"
      },
      :transactions => [
        {
          :amount => {
            :total => session[:price],
            :currency => "EUR"
          },
          :description =>  "payment description.",
          :item_list => {
            :items => @items
          }
        }
      ]
    })

    if payment.create
      @redirect_url = payment.links.find{ |v| v.rel == "approval_url" }.href
      puts "success"
    else
      logger.error payment.error.inspect
      puts "fail"
    end

    payment_id = ENV["PAYMENT_ID"]
    #payment = PayPal::SDK::REST::Payment.find(payment_id)

    #if payment.execute(:payer_id => ENV["PAYER_ID"])
    #  PayPal::SDK.logger.info "Payment[#{payment.id}] executed successfully"
    #else
    #  PayPal::SDK.logger.error payment.error.inspect
    #end


#    session[:cart].each do |ol|
#      payment.transactions.item_list.items  << {
#        :name => Item.find(ol.item_id).name,
#        :sku => Item.find(ol.item_id).name,
#        :price => Item.find(ol.item_id).price.to_s,
#        :currency => "EUR",
#        :quantity => ol.item_amount
#      }
#    end
  end

  def express_checkout
    @price_cent = session[:price].to_i * 100
    response = EXPRESS_GATEWAY.setup_purchase(
      @price_cent,
      ip: request.remote_ip,
      return_url: paypal_purchase_url,
      cancel_return_url: paypal_cancel_url,
      currency: "EUR",
      allow_guest_checkout: true,
      items: @items
    )
    redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token, review: true)
  end

  def purchase 
    detail = EXPRESS_GATEWAY.details_for(params[:token])

    response = EXPRESS_GATEWAY.purchase(
      @price_cent,
      ip: request.remote_ip,
      token: params[:token],
      payer_id: params[:PayerID],
      notify_url: paypal_ipn_path
    )
    
    if response.success?
      redirect_to paypal_complete_path
    else 
      logger.error response.message
      redirect_to paypal_cancel_path
    end
  end

  def complete
  end

  def cancel
  end

  def ipn
    response = OffsitePayments::Integrations::Paypal::Notification.new(request.raw_post).extend(PaypalNotification)

    unless response.acknowledge
      logger.error 'invalid ipn'
      render nothing: true, status: :bad_request
    end

    if response.completed?(@price_cent)
      logger.info 'completed'
    elsif response.refunded?(@price_cent)
      logger.info 'refunded'
    else
      logger.error 'failed'
    end

    render nothing: true
  end
end
