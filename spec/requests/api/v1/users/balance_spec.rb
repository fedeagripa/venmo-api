require 'rails_helper'

describe 'GET api/v1/users/:id/balance', type: :request do
  let(:user) { create(:user) }

  it 'returns success' do
    get balance_api_v1_user_path(id: user.id), headers: auth_headers, as: :json
    expect(response).to have_http_status(:success)
  end

  it 'returns balance data' do
    get balance_api_v1_user_path(id: user.id), headers: auth_headers, as: :json

    expect(json[:balance]).to eq user.balance
  end
end
