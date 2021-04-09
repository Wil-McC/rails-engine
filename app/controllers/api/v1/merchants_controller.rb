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

  def most_revenue
    limit = params[:quantity].to_i
    if limit > 0 && limit.class == Integer
      render json: MerchantRevenueSerializer.new(Merchant.top_revenue(limit))
    else
      render status: 400
    end
  end

  def total_revenue
    merchant = Merchant.find(params[:id])

    render json: MerchantTotalSerializer.new(Merchant.total_revenue(merchant.id)[0])
  rescue ActiveRecord::RecordNotFound
    render status: 404
  end
end
