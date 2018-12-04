require 'rails_helper'

describe 'POST api/v1/users/:id/payment', type: :request do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let(:friend) { create(:user) }
  let!(:frienship) { create(:user_friend, user: user, friend: friend) }

  context 'with frienship' do
    let(:params) { { friend_id: friend.id, amount: 100 } }
    let(:wrong_params) { { friend_id: friend.id, amount: 0 } }

    it 'returns success' do
      post payment_api_v1_user_path(id: user.id), params: params, headers: auth_headers, as: :json
      expect(response).to have_http_status(:success)
    end

    it 'returns amount is not valid' do
      post payment_api_v1_user_path(id: user.id), params: wrong_params, headers: auth_headers, as: :json
      expect(json[:errors][:amount]).to eq(["Amount should be between 1 & 1000"])
    end
  end

  context 'with no frienship' do
    let(:params) { { friend_id: user2.id, amount: 100 } }

    it 'returns users must be friends' do
      post payment_api_v1_user_path(id: user.id), params: params, headers: auth_headers, as: :json
      expect(json[:errors][:receiver_id]).to eq(["Users must be friends"])
    end
  end
end
