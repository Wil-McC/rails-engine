require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many :items }
    it { should have_many :invoices }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:invoice_items).through(:items) }
  end
  describe 'scope #paginate' do
    before :each do
      @m1 = create(:merchant)
      @m2 = create(:merchant)
      @m3 = create(:merchant)
      @m4 = create(:merchant)
      @m5 = create(:merchant)
      @m6 = create(:merchant)
    end
    it "returns 20 results by default" do
      create_list(:merchant, 20)

      call = Merchant.paginate(1)
      call2 = Merchant.paginate(2)

      expect(call.length).to eq(20)
      expect(call2.length).to eq(6)
    end
    it 'returns paginated results based on params' do
      call = Merchant.paginate(2 , 3)

      expect(call.length).to eq(3)
      expect(call).to eq([@m4, @m5, @m6])
    end
  end
  describe '#all_items' do
    before :each do
      @m = create(:merchant)
      @m2 = create(:merchant)

      @i1 = create(:item, merchant_id: @m.id)
      @i2 = create(:item, merchant_id: @m.id)
      @i3 = create(:item, merchant_id: @m.id)
      @i4 = create(:item, merchant_id: @m.id)
      @i5 = create(:item, merchant_id: @m.id)

      @i6 = create(:item, merchant_id: @m2.id)
      @i7 = create(:item, merchant_id: @m2.id)
    end
    it 'returns all associated items' do
      res = @m.all_items

      expect(res.length).to eq(5)
      expect(res).to eq([@i1, @i2, @i3, @i4, @i5])
      expect(res[0].name).to eq(@i1.name)
      expect(res[0].description).to eq(@i1.description)
      expect(res[0].unit_price).to eq(@i1.unit_price)
      expect(res[0].merchant_id).to eq(@i1.merchant_id)
      expect(res[4].name).to eq(@i5.name)
    end
  end
  describe '#find' do
    before :each do
      @m1 = create(:merchant, name: 'Adama Cotton')
      @m2 = create(:merchant, name: 'Walcott Fabrics')
    end
    it 'returns first alphabetical match' do
      res = Merchant.find_first('cot')

      expect(res).to eq(@m1)
    end
  end
  describe '::top_revenue' do
    it '' do
    end
  end
  describe '::total_revenue' do
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
      t1 = Merchant.total_revenue(@m1.id)

      expect(t1.length).to eq(1)
      expect(t1[0].revenue).to be_a(Float)
    end
  end
end
