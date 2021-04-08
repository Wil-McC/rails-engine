require 'rails_helper'

RSpec.describe 'merchant find one endpoint' do
  before :each do
    @m1 = create(:merchant, name: 'Adama Cotton')
    @m2 = create(:merchant, name: 'Walcott Fabrics')
  end
  it 'returns serialized info for first db name match' do
    get '/api/v1/merchants/find?name=cot'
    expect(response).to be_successful
    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant.keys).to eq([:data])
    expect(merchant[:data].keys).to eq([:id, :type, :attributes])
    expect(merchant[:data][:type]).to eq('merchant')
    expect(merchant[:data][:attributes].keys).to eq([:name])
  end
  it "returns 200 OK and empty response for no match" do
    get '/api/v1/merchants/find?name=xyz'
    expect(response).to be_successful
    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant.keys).to eq([:data])
    expect(merchant[:data]).to eq({})
  end
end
