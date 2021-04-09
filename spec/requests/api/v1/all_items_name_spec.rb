require 'rails_helper'

RSpec.describe 'the all items by name fragment request' do
  before :each do
    @m1 = create(:merchant)

    @i1 = create(:item, name: 'XYZ', merchant_id: @m1.id)
    @i2 = create(:item, name: 'Cormorantz', merchant_id: @m1.id)
    @i3 = create(:item, name: 'Fellows and Sons', merchant_id: @m1.id)
    @i4 = create(:item, name: 'Endering Slows', merchant_id: @m1.id)
  end
  it 'returns all items with partial matches' do
    get '/api/v1/items/find_all?name=LoWS'
    expect(response).to be_successful
    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants.keys).to eq([:data])
    expect(merchants[:data].length).to eq(2)
    expect(merchants[:data][0].keys).to eq([:id, :type, :attributes])
    expect(merchants[:data][0][:attributes][:name]).to eq(@i3.name)
    expect(merchants[:data][1][:attributes][:name]).to eq(@i4.name)
  end
end
