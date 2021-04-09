require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end
  describe 'class methods' do
    describe '::find_all' do
      before :each do
        @m1 = create(:merchant)

        @i1 = create(:item, name: 'XYZ', merchant_id: @m1.id)
        @i2 = create(:item, name: 'Cormorantz', merchant_id: @m1.id)
        @i3 = create(:item, name: 'Fellows and Sons', merchant_id: @m1.id)
        @i4 = create(:item, name: 'Endering Slows', merchant_id: @m1.id)
      end
      it 'finds all partial matching items' do
        match1 = Item.find_all('LOw')
        match2 = Item.find_all('Z')

        expect(match1.length).to eq(2)
        expect(match2.length).to eq(2)
      end
    end
  end
end
