class Api::V1::MerchantsController < ApplicationController
  def index
    page = (params[:page] || 1).to_i
    page = 1 if page <= 0
    per_page = (params[:per_page] || 20).to_i
    render json: MerchantSerializer.new(Merchant.paginate(page, per_page))
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end

  def find
    name = params[:name]
    if Merchant.find_first(name)
      render json: MerchantSerializer.new(Merchant.find_first(name))
    else
      render json: { data: {} }
    end
  end
end
