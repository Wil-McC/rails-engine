class Api::V1::InvoicesController < ApplicationController
  def unshipped_revenue
    limit = (params[:quantity] || 10).to_i
    if limit > 0 && limit.class == Integer
      render json: UnshippedSerializer.new(Invoice.unshipped_revenue(limit))
    else
      render status: 400
    end
  end
end
