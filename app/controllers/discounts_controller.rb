class DiscountsController < ApplicationController
  before_action :find_merchant
  def index
    # @merchant = Merchant.find(params[:merchant_id])
    @discounts = @merchant.discounts
  end

  def show
    # @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id])
  end

  def edit
    @discount = Discount.find(params[:id])
  end

  def update
    discount = Discount.find(params[:id])
    if discount.update(discount_params)
    redirect_to  merchant_discount_path(@merchant, discount)
    flash[:alert] = "Discount has been updated"
  else
    redirect_to edit_merchant_discount_path(@merchant, discount)
    flash[:alert] = "Error: #{error_message(discount.errors)}"
    end
  end

  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  private
  def discount_params
    params.require(:discount).permit(:name, :percentage, :threshold)
  end
end
