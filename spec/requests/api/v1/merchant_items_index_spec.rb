require 'rails_helper'

RSpec.describe 'the merchant items index endpoint' do
  before :each do
    @m = create(:merchant)

    @i1 = create(:item, merchant_id: @m.id)
    @i2 = create(:item, merchant_id: @m.id)
    @i3 = create(:item, merchant_id: @m.id)
    @i4 = create(:item, merchant_id: @m.id)
    @i5 = create(:item, merchant_id: @m.id)
  end
  it 'returns all merchant items' do
    get "/api/v1/merchants/#{@m.id}/items"
    expect(response).to be_successful
    merchant = JSON.parse(response.body, symbolize_names: true)
  end
end
