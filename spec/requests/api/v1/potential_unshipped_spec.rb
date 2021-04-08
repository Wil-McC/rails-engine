require 'rails_helper'

RSpec.describe 'unshipped potential revenue request' do
  before :each do
    @m1 = create(:merchant)
    @m2 = create(:merchant)
    @cust = create(:customer)

    @invoice1 = create(:invoice, customer_id: @cust.id, merchant_id: @m1.id, status: 'packaged')
    @invoice2 = create(:invoice, customer_id: @cust.id, merchant_id: @m2.id, status: 'packaged')
    @invoice3 = create(:invoice, customer_id: @cust.id, merchant_id: @m2.id)
    @invoice4 = create(:invoice, customer_id: @cust.id, merchant_id: @m2.id, status: 'returned')

    @item1 = create(:item, merchant_id: @m1.id)
    @item2 = create(:item, merchant_id: @m1.id)
    @item3 = create(:item, merchant_id: @m2.id)
    @item4 = create(:item, merchant_id: @m2.id)

    @t1 = create(:transaction, invoice_id: @invoice1.id, result: 'success')
    @t2 = create(:transaction, invoice_id: @invoice1.id, result: 'success')
    @t3 = create(:transaction, invoice_id: @invoice2.id, result: 'success')
    @t4 = create(:transaction, invoice_id: @invoice2.id, result: 'success')
    @t5 = create(:transaction, invoice_id: @invoice3.id, result: 'success')
    @t6 = create(:transaction, invoice_id: @invoice4.id, result: 'success')

    @ii1 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice1.id)
    @ii2 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice1.id)
    @ii3 = create(:invoice_item, item_id: @item3.id, invoice_id: @invoice2.id)
    @ii4 = create(:invoice_item, item_id: @item4.id, invoice_id: @invoice2.id)
    @ii5 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice3.id)
    @ii6 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice4.id)
  end
  it 'returns serialized info with potential revenue' do
    get '/api/v1/revenue/unshipped'
    expect(response).to be_successful
    tops = JSON.parse(response.body, symbolize_names: true)

    expect(tops.keys).to eq([:data])
    expect(tops[:data][0].keys).to eq([:id, :type, :attributes])
    expect(
      tops[:data].all? do |invoice|
        invoice.keys == [:id, :type, :attributes]
      end
    ).to eq(true)
    expect(
      tops[:data].all? do |invoice|
        invoice[:attributes].keys == [:revenue]
      end
    ).to eq(true)
  end
end
