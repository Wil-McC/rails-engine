require 'rails_helper'

RSpec.describe 'the merchant total revenue request' do
  before :each do
    @m1 = create(:merchant)
    @m2 = create(:merchant)
    @cust = create(:customer)

    @invoice1 = create(:invoice, customer_id: @cust.id, merchant_id: @m1.id)
    @invoice2 = create(:invoice, customer_id: @cust.id, merchant_id: @m2.id)

    @item1 = create(:item, merchant_id: @m1.id)
    @item2 = create(:item, merchant_id: @m1.id)
    @item3 = create(:item, merchant_id: @m1.id)
    @item4 = create(:item, merchant_id: @m1.id)

    @t1 = create(:transaction, invoice_id: @invoice1.id, result: 'success')
    @t2 = create(:transaction, invoice_id: @invoice1.id, result: 'success')
    @t3 = create(:transaction, invoice_id: @invoice2.id, result: 'success')
    @t4 = create(:transaction, invoice_id: @invoice2.id, result: 'success')

    @ii1 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice1.id)
    @ii2 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice1.id)
    @ii3 = create(:invoice_item, item_id: @item3.id, invoice_id: @invoice2.id)
    @ii4 = create(:invoice_item, item_id: @item4.id, invoice_id: @invoice2.id)
  end
  it 'returns total revenue for a single merchant' do
    get "/api/v1/revenue/merchants/#{@m1.id}"
    expect(response).to be_successful
    total = JSON.parse(response.body, symbolize_names: true)

    expect(total.keys).to eq([:data])
    expect(total[:data].keys).to eq([:id, :type, :attributes])
    expect(total[:data][:attributes].keys).to eq([:revenue])
    expect(total[:data][:attributes][:revenue]).to be_a(Float)
  end
  it "returns a 404 error if no matching id" do
    get "/api/v1/revenue/merchants/9999999"
    expect(response).to_not be_successful
  end
end
