require 'rails_helper'

describe "Applications API", type: :request do

  describe "GET /applications" do
    it 'returns all applications' do
      FactoryBot.create(:application , token:'acdasdgvcz', application_name:'app-1')
      get '/api/v1/applications'

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(1)
    end
  end

  describe "GET /applications/{token}" do
    it 'returns application by token' do
      get '/api/v1/applications/acdasdgvcz'

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(1)
    end
  end

  describe "POST /applications" do
    it 'create a new application' do
      expect{
        post '/api/v1/applications', params: { application:{application_name:"app-2"}}
      }.to change {Application.count}.from(0).to(1)

      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /applications/{token}" do
    it 'update an application' do
      FactoryBot.create(:application , token:'kkdahsdhc', application_name:'app-3')
      patch '/api/v1/applications/kkdahsdhc', params: { application:{application_name:"app3"}}

      expect(response).to have_http_status(:success)
    end
  end


end