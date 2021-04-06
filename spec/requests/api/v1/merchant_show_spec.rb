require 'rails_helper'

RSpec.describe 'merchant by id query' do
  it 'returns merchant with matching id' do
    m1 = create(:merchant, id: 1)
    m2 = create(:merchant, id: 2)
    m3 = create(:merchant, id: 3)
    m4 = create(:merchant, id: 4)
    m5 = create(:merchant, id: 5)

    get '/api/v1/merchants/5'

    expect(response).to be_successful
    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:data][:id]).to eq("5")
    expect(merchant[:data][:id]).to be_a(String)
    expect(merchant[:data].keys.length).to eq(3)
    expect(merchant[:data][:attributes].length).to eq(1)
    expect(merchant[:data][:type]).to eq("merchant")
  end
end
