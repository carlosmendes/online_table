class OrderLinesController < ApplicationController
  before_action :check_create_permission
  before_action :set_order_line, only: [:show, :edit, :update, :destroy]

  # GET /order_lines
  # GET /order_lines.json
  def index
    @order_lines = OrderLine.all
  end

  # GET /order_lines/1
  # GET /order_lines/1.json
  def show
  end

  # GET /order_lines/new
  def new
    @order_line = OrderLine.new
  end

  # GET /order_lines/1/edit
  def edit
  end

  # POST /order_lines
  # POST /order_lines.json
  def create
    @order_line = OrderLine.new(order_line_params)
    
    if @order_line.order_id.nil?
      @order_line.order_id = current_order.id
      @order_line.value = @order_line.product.price*@order_line.quantity
      @order_line.status = OrderLine.status_requested
    end
    respond_to do |format|
      if @order_line.save
        # inform client
        WebsocketRails['order_lines_'+@order_line.order.id.to_s].trigger 'new', {:order => @order_line.order, :order_line => @order_line, :product => @order_line.product}
        format.html { redirect_to @order_line, notice: 'Order line was successfully created.' }
        format.json { render :show, status: :created, location: @order_line }
      else
        format.html { render :new }
        format.json { render json: @order_line.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /order_lines/1
  # PATCH/PUT /order_lines/1.json
  def update
    respond_to do |format|
      if @order_line.update(order_line_params)
        format.html { redirect_to @order_line, notice: 'Order line was successfully updated.' }
        format.json { render :show, status: :ok, location: @order_line }
      else
        format.html { render :edit }
        format.json { render json: @order_line.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order_lines/1
  # DELETE /order_lines/1.json
  def destroy
    @order_line.destroy
    respond_to do |format|
      format.html { redirect_to order_lines_url, notice: 'Order line was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /order_lines_pending.json
  def pending
    @pendingOrderLines = OrderLine.get_pending
  end
  
  # GET /order_lines/1/deliver.json  
  def deliver
      order_line = OrderLine.find(params[:id])
      order_line.status = OrderLine.status_delivered
      respond_to do |format|
        if order_line.save
          @pendingOrderLines = OrderLine.get_pending
          format.json { render :pending, status: :ok }
        else
          format.json { render json: @order_line.errors, status: :unprocessable_entity }
        end
      end    
  end
  
  # GET /order_lines/1/process_line.json  
  def process_line
      order_line = OrderLine.find(params[:id])
      order_line.status = OrderLine.status_processing
      respond_to do |format|
        if order_line.save
          @pendingOrderLines = OrderLine.get_pending
          format.json { render :pending, status: :ok }
        else
          format.json { render json: @order_line.errors, status: :unprocessable_entity }
        end
      end    
  end
  
  # GET /order_lines/1/cancel.json  
  def cancel
      order_line = OrderLine.find(params[:id])
      order_line.status = OrderLine.status_canceled
      respond_to do |format|
        if order_line.save
          @pendingOrderLines = OrderLine.get_pending
          format.json { render :pending, status: :ok }
        else
          format.json { render json: order_line.errors, status: :unprocessable_entity }
        end
      end    
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_line
      @order_line = OrderLine.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_line_params
      params.require(:order_line).permit(:order_id, :product_id, :quantity, :value, :status)
    end
    
    def check_create_permission
      if params[:id]
        order_line = OrderLine.find(params[:id])
      else
        order_line = OrderLine.new(order_line_params)
      end
      if order_line.order_id.nil?
        order = current_order
      else
        order = order_line.order
      end
      check_manager || check_waiter || order.client_id == current_user.id unless !logged_in? || order.session_cookie == get_unregistered_cookie
    end
end
