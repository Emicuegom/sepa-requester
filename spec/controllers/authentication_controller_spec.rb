require 'rails_helper'

RSpec.describe AuthenticationController, type: :controller do
  let(:user) {create(:user, name: 'userone', username: 'userone', email: 'userone@mailinator.com')}
  let(:request) {
    post :login, params: params
  }
  let(:params) do
    {
      email: user.email,
      password: '123456'
    }
  end
  it 'login successfully' do
    expect(request).to have_http_status(:ok)
    expect(JSON.parse(request.body)["token"]).to be_present
    expect(JSON.parse(request.body)["username"]).to eq(user.username)
  end

  context 'login unsuccessfully' do
    let(:params) do
      {
        email: user.email,
        password: '12345'
      }
    end
    it { expect(request).to have_http_status(:unauthorized) }
  end
end
