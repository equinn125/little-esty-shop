class ItemsController < ApplicationController
    def index
      @merchant = Merchant.find(params[:merchant_id])
      @merchant_items = @merchant.items
    end

    def show
      # binding.pry
      @item = Item.find(params[:id])
    end
end
