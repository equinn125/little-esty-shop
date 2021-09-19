class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def new
    @merchant = Merchant.new
  end

  def create
    merchant =  Merchant.create(merchant_params)
    if merchant.save
      redirect_to "/admin/merchants"
      flash[:alert] = "New Merchant has been created"
    else
      redirect_to "/admin/merchants/new"
      flash[:alert] = "Error: #{error_message(merchant.errors)}"
    end
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant =  Merchant.find(params[:id])
  if params[:status]
    merchant.update(status: params[:status])
    redirect_to "/admin/merchants"
  elsif merchant.update(merchant_params)
      redirect_to "/admin/merchants/#{merchant.id}"
      flash[:alert] = "Merchant has been updated"
    else
      redirect_to "/admin/merchants/#{merchant.id}/edit"
      flash[:alert] = "Error: #{error_message(merchant.errors)}"
    end
  end

  private
  def merchant_params
    params.require(:merchant).permit(:name)
  end
end
