require 'rails_helper'

RSpec.describe PaymentRequestsController, type: :controller do
  let(:user) { create(:user, name: 'userone', username: 'userone', email: 'userone@mailinator.com') }
  let(:params) do
    {
      full_name: 'aaa',
      amount_cents: 10000,
      amount_currency: 'EUR',
      iban: 'GB33BUKB20201555555555'
    }
  end
  before do
    allow_any_instance_of(described_class).to receive(:authorize_request).and_return(@current_user = user)
    company_user = user
    controller.instance_eval do
      @current_user = company_user
    end
  end
  context 'index' do
    let(:response) { get :index }
    before do
      post :create, params: params
    end
    it do
      expect(JSON.parse(response.body)).to be_present
    end
  end
  context 'create' do
    let(:response) { post :create, params: params }

    it do
      expect { response }.to change{PaymentRequest.count}.by(1)
    end
  end
  context 'show' do
    let(:response) { get :show, params: show_params }
    let(:show_params) do
      {
        id: user.reload.payment_requests.first.id
      }
    end
    let(:body) {JSON.parse(response.body)}
    before do
      post :create, params: params
    end
    it do
      expect(body['full_name']).to eq('aaa')
      expect(body['amount_cents']).to eq(10000)
      expect(body['amount_currency']).to eq('EUR')
      expect(body['iban']).to eq('GB33BUKB20201555555555')
      expect(body['status']).to eq('new')
    end
  end
end
