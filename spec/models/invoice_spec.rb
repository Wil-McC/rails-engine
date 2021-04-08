require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to :customer }
    it { should belong_to :merchant }
    it { should have_many :transactions }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
  end
  describe 'class methods' do
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
    it 'returns packaged invoice info' do
      out = Invoice.unshipped_revenue(10)

      expect(out.length).to eq(2)
      expect(out[0].class).to eq(Invoice)
      expect(out[1].class).to eq(Invoice)
      expect(out[0].revenue).to be_a(Float)
      expect(out[1].revenue).to be_a(Float)
    end
  end
end
