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
    it 'returns paginated results based on params' do
      call = Merchant.paginate(2 , 3)

      expect(call.length).to eq(3)
    end
  end
end
