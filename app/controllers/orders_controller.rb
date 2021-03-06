class OrdersController < ApplicationController
  before_action :check_manager, only: [:show, :edit, :update, :destroy]
  before_action :check_waiter, only: [:waiting_waiter, :waiting_payment, :processing, :pay, :cancel]
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    if params[:table_token]
      table = Table.where(:token => params[:table_token]).first
      @order = Order.new(:table_id => table.id)
    else
      @order = Order.new
    end
    @order.status = Order.status_draft
    @order.client_id = current_user.id
    @order.order_lines.build
  end

  # GET /orders/1/edit
  def edit
    #@order.order_lines.build
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)    
    @order.session_cookie = get_unregistered_cookie
    
    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
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

  def current
    @order = current_order  
  end

  # GET /orders/1/request_waiter.json  
  def request_waiter
      order = Order.find(params[:id])
      order.status = Order.status_waiter_requested
      respond_to do |format|
        if order.save
          @order = order 
          format.json { render :current, status: :ok }
        else
          format.json { render json: order.errors, status: :unprocessable_entity }
        end
      end    
  end
  
  # GET /orders_waiting_waiter.json 
  def waiting_waiter
    @orders = Order.where(:status => Order.status_waiter_requested).order(:updated_at)  
    respond_to do |format|
      format.json { render :index, status: :ok}
    end
  end

  # GET /orders/1/processing.json  
  def processing
      order = Order.find(params[:id])
      order.status = Order.status_processing
      respond_to do |format|
        if order.save
          @orders = Order.where(:status => Order.status_waiter_requested).order(:updated_at)   
          format.json { render :index, status: :ok }
        else
          format.json { render json: order.errors, status: :unprocessable_entity }
        end
      end    
  end
  
  # GET /orders/1/request_payment.json  
  def request_payment
      order = Order.find(params[:id])
      order.status = Order.status_payment_requested
      respond_to do |format|
        if order.save
          @order = order 
          format.json { render :current, status: :ok }
        else
          format.json { render json: order.errors, status: :unprocessable_entity }
        end
      end    
  end

  # GET /orders_waiting_payment.json 
  def waiting_payment
    @orders = Order.where(:status => Order.status_payment_requested).order(:updated_at)  
    respond_to do |format|
      format.json { render :index, status: :ok}
    end
  end

  # GET /orders/1/pay.json  
  def pay
      order = Order.find(params[:id])
      order.status = Order.status_paied
      respond_to do |format|
        if order.save
          @orders = Order.where(:status => Order.status_payment_requested).order(:updated_at)   
          format.json { render :index, status: :ok }
        else
          format.json { render json: order.errors, status: :unprocessable_entity }
        end
      end    
  end
  
  # GET /orders/1/cancel.json  
  def cancel
      order = Order.find(params[:id])
      order.status = Order.status_canceled
      respond_to do |format|
        if order.save
          @order = order  
          format.json { render :show, status: :ok }
        else
          format.json { render json: order.errors, status: :unprocessable_entity }
        end
      end    
  end
        
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:client_id, :waiter_id, :table_id, :status, order_lines_attributes:[:id, :product_id, :quantity, :value, :status, :order_id, :_destroy])
    end
end
