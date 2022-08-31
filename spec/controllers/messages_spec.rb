require 'rails_helper'

describe "Messages API", type: :request do

  describe "GET /applications/{token}/chats/{chat_number}/messages" do
    it 'returns all messages to specific chat under application' do
      application = FactoryBot.create(:application , token:'kkasdkwkckaj', application_name:'app-3')
      chat = FactoryBot.create(:chat , chat_name: "chat-1", number: 1 , application_id: application.id)
      FactoryBot.create(:message , message: "message-1", number: 1 , chat_id: chat.id)

      get '/api/v1/applications/kkasdkwkckaj/chats/1/messages'

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(1)
    end
  end

  describe "GET /applications/{token}/chats/{chat_number}/message/{message_number}" do
    it 'returns message by number for specific chat under application' do
      get '/api/v1/applications/kkasdkwkckaj/chats/1/messages/1'

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(1)
    end
  end

  describe "PATCH /applications/{token}/chats/{chat_number}/messages/{message_number}" do
    it 'update an chat by number for specific application' do
      application = FactoryBot.create(:application , token:'lasdghnlsakd', application_name:'app-4')
      chat = FactoryBot.create(:chat , chat_name: "chat-1", number: 1 , application_id: application.id)
      FactoryBot.create(:message , message: "message-1", number: 1 , chat_id: chat.id)

      patch '/api/v1/applications/lasdghnlsakd/chats/1', params: { message:{message:"message1"}}

      expect(response).to have_http_status(:success)
    end
  end

end