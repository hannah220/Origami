class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def index
    @orders = Order.where(:status => 'placed')
    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => orders }
    end
  end 
  # DELETE /orders/1
  # DELETE /orders/1.json

  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def handle
    @order = Order.find(params[:id])
    @price = @order.order_line.inject(0) do |sum,l|
      sum + l.item_amount * l.item.price
    end
    @shipping_addr = ShippingAddr.all
  end

  def handled
    @order = Order.find(params[:id])
    @order.status = 'handled'
    if @order.save 
      flash[:notice] = 'Order has been processed'
      redirect_to :action => 'index'
    else 
     @price = @order.order_line.inject(0) do |sum,l|
      sum + l.item_amount * l.item.price
     end
     render :action => 'handle'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:customer_id, :order_date, :ship_date, :status)
    end
end
