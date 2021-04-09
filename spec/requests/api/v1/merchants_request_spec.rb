require 'rails_helper'

RSpec.describe 'Merchants API' do
  it 'sends a list of merchants' do
    create_list(:merchant, 5)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants.count).to eq(1)
    expect(merchants[:data].length).to eq(5)
    merchants[:data].each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(String)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end
  it "sends a default of 20 results per page" do
    create_list(:merchant, 45)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].length).to eq(20)
    expect(merchants[:data]).to be_an(Array)
    expect(merchants[:data][0][:attributes][:name]).to be_a(String)
  end
  it "sends results based on page and perpage query params" do
    create_list(:merchant, 45)

    # with only per page param
    get '/api/v1/merchants?per_page=40'

    expect(response).to be_successful
    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].length).to eq(40)

    # with per page and page number params
    get '/api/v1/merchants?per_page=40&page=2'

    expect(response).to be_successful
    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].length).to eq(5)
  end
  it "returns page 1 with 20 results if negative or 0 params are passed" do
    create_list(:merchant, 22)
    get '/api/v1/merchants?page=0'
    expect(response).to be_successful
    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].length).to eq(20)
    get '/api/v1/merchants?page=-10'
    expect(response).to be_successful
    merchants = JSON.parse(response.body, symbolize_names: true)
    expect(merchants[:data].length).to eq(20)
  end
end
