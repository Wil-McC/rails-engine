class Api::V1::ItemsController < ApplicationController
  def find_all
    string = params[:name]

    render json: ItemSerializer.new(Item.find_all(string))
  end
end
