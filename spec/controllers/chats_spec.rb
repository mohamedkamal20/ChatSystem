require 'rails_helper'

describe "Chats API", type: :request do

  describe "GET /applications/{token}/chats" do
    it 'returns all chats to specific application' do
      application = FactoryBot.create(:application , token:'kkasdkwkckaj', application_name:'app-3')
      FactoryBot.create(:chat , chat_name: "chat-1", number: 1 , application_id: application.id)

      get '/api/v1/applications/kkasdkwkckaj/chats'

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(1)
    end
  end

  describe "GET /applications/{token}/chats/{chat_number}" do
    it 'returns chat by number for specific application' do
      get '/api/v1/applications/kkasdkwkckaj/chats/1'

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(1)
    end
  end

  describe "PATCH /applications/{token}/chats/{chat_number}" do
    it 'update an chat by number for specific application' do
      application = FactoryBot.create(:application , token:'lasdghnlsakd', application_name:'app-4')
      FactoryBot.create(:chat , chat_name: "chat-1", number: 1 , application_id: application.id)
      patch '/api/v1/applications/lasdghnlsakd/chats/1', params: { chat:{chat_name:"chat1"}}

      expect(response).to have_http_status(:success)
    end
  end

end