class OrderDetailsController < ApplicationController
  before_action :set_order_detail, only: [:show, :edit, :update, :destroy]

  # GET /order_details
  # GET /order_details.json
  def index
    order_users = OrderUser.select('id').where('order_id = (?) ',params[:order_id])
    @order_details = OrderDetail.where('order_user_id IN (?) ',order_users)
    @order = Order.find(params[:order_id])
    @invited_users = Order.find(params[:order_id]).order_users.where('status = 0').count
    @joined_users = Order.find(params[:order_id]).order_users.where('status = 1').count
  end

  # GET /order_details/1
  # GET /order_details/1.json
  def show
  end

  # GET /order_details/new
 
  def new
    @order_info = OrderDetail.where('order_user_id = (?) ',params[:order_user_id]).count
    @order_detail = OrderDetail.new
  end

  # GET /order_details/1/edit
  def edit
  end

  # POST /order_details
  # POST /order_details.json
  def create
    @orderUser= OrderUser.find( params[:order_user_id])
    @order_detail = @orderUser.order_details.build(order_detail_params)

    respond_to do |format|
      if @order_detail.save
        format.html { redirect_to order_order_user_order_details_path, notice: 'Order detail was successfully created.' }
        format.json { render :show, status: :created, location: @order_detail }
      else
        format.html { render :new }
        format.json { render json: @order_detail.errors, status: :unprocessable_entity }
      end
    end
end

  # PATCH/PUT /order_details/1
  # PATCH/PUT /order_details/1.json
  def update
    respond_to do |format|
      if @order_detail.update(order_detail_params)
        format.html { redirect_to order_order_user_order_details_path, notice: 'Order detail was successfully updated.' }
        format.json { render :show, status: :ok, location: @order_detail }
      else
        format.html { render :edit }
        format.json { render json: @order_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order_details/1
  # DELETE /order_details/1.json
  def destroy
    @order_detail.destroy
    respond_to do |format|
      format.html { redirect_to order_order_user_order_details_path, notice: 'Order detail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_detail
      @order_detail = OrderDetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_detail_params
      params.require(:order_detail).permit(:item, :amount, :price, :comment, :order_user_id)
    end
end
