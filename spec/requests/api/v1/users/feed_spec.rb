require 'rails_helper'

describe 'GET api/v1/users/:id/feed', type: :request do
  let(:user) { create(:user) }
  let(:friend) { create(:user) }
  let!(:frienship) { create(:user_friend, user: user, friend: friend) }
  let!(:payment) { create(:payment, user: user, receiver: friend) }

  it 'returns success' do
    get feed_api_v1_user_path(id: user.id), headers: auth_headers, as: :json
    expect(response).to have_http_status(:success)
  end

  it 'returns feed data' do
    get feed_api_v1_user_path(id: user.id), headers: auth_headers, as: :json
    expect(json[:feed][0][:user]).to eq user.id
    expect(json[:feed][0][:receiver]).to eq friend.id
    expect(json[:feed][0][:amount]).to eq payment.amount
    expect(json[:feed][0][:title]).to eq payment.title
  end
end
