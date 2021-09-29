class DiscountsController < ApplicationController
  before_action :find_merchant
  def index
    @discounts = @merchant.discounts
    @holidays = DiscountsFacade.new.holidays
  end

  def show
    @discount = Discount.find(params[:id])
  end

  def new
    @discount = Discount.new
  end

  def create
    discount = @merchant.discounts.create(discount_params)
    if discount.save
      redirect_to merchant_discounts_path(@merchant)
      flash[:alert] = "New Discount has been created"
    else
      redirect_to new_merchant_discount_path(@merchant)
      flash[:alert] = "Error: #{error_message(discount.errors)}"
    end
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

  def destroy
    discount = Discount.find(params[:id])
    discount.destroy
    redirect_to merchant_discounts_path(@merchant, discount)
  end

  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  private
  def discount_params
    params.require(:discount).permit(:name, :percentage, :threshold)
  end
end
