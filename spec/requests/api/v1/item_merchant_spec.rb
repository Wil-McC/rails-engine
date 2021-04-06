require 'rails_helper'

RSpec.describe 'the item merchant request' do
  before :each do
    @m = create(:merchant)

    @i1 = create(:item, merchant_id: @m.id)
  end
  it 'returns merchant info for an item' do
    get "/api/v1/items/#{@i1.id}/merchant"
    expect(response).to be_successful
    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant.length).to eq(1)
    expect(merchant[:data].length).to eq(3)
    expect(merchant[:data][:attributes].length).to eq(1)
    expect(merchant[:data][:id]).to eq((@m.id).to_s)
    expect(merchant[:data][:type]).to eq('merchant')
    expect(merchant[:data][:attributes][:name]).to eq(@m.name)
  end
end
