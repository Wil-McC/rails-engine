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
end
