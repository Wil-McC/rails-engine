class Api::V1::InvoicesController < ApplicationController
  def unshipped_revenue
    limit = (params[:quantity] || 10).to_i
    render json: UnshippedSerializer.new(Invoice.unshipped_revenue(limit))
  end
end
