require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many :items }
    it { should have_many :invoices }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:invoice_items).through(:invoices) }
  end
  describe '#paginate' do
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
end
