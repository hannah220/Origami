module ApplicationHelper
  def get_category_name(c_id)
    c = @categories.select{|c| c[:id] == c_id}
    c.first[:name]
  end

  def get_total_price(order)
    @price = order.order_line.inject(0) do |sum,l|
      sum + l.item_amount * l.item.price
    end
    number_to_currency(@price, :unit => "€")
  end

  def get_total_amount(order)
    order.order_line.inject(0) do |sum,l|
      sum + l.item_amount
    end
  end

  def get_shipping_street(order)
    addr_id = order.customer.shipping_addr_id
    street = @shipping_addr.find(addr_id).street
  end

  def get_shipping_postal(order)
    addr_id = order.customer.shipping_addr_id
    postal = @shipping_addr.find(addr_id).postal
  end

  def get_shipping_zip(order)
    addr_id = order.customer.shipping_addr_id
    postal = @shipping_addr.find(addr_id).zip
  end
  
  def get_shipping_country(order)
    addr_id = order.customer.shipping_addr_id
    postal = @shipping_addr.find(addr_id).country
  end

  def get_billing_street(order)
    addr_id = order.customer.shipping_addr_id
    street = @shipping_addr.find(addr_id).street
  end

  def get_billing_postal(order)
    addr_id = order.customer.shipping_addr_id
    postal = @shipping_addr.find(addr_id).postal
  end

  def get_billing_zip(order)
    addr_id = order.customer.shipping_addr_id
    postal = @shipping_addr.find(addr_id).zip
  end
  
  def get_billing_country(order)
    addr_id = order.customer.shipping_addr_id
    postal = @shipping_addr.find(addr_id).country
  end

end
