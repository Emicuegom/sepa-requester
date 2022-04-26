require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  context 'index' do
    let(:user) { create(:user, name: 'userone', username: 'userone', email: 'userone@mailinator.com') }
    before do
      allow_any_instance_of(described_class).to receive(:authorize_request).and_return(@current_user = user)
      company_user = user
      controller.instance_eval do
        @current_user = company_user
      end
    end
    let(:response) { get :index }
    it do
      expect(JSON.parse(response.body)).to be_present
    end
  end
  context 'show' do
    let(:user) { create(:user, name: 'userone', username: 'userone', email: 'userone@mailinator.com') }
    before do
      allow_any_instance_of(described_class).to receive(:authorize_request).and_return(@current_user = user)
      company_user = user
      controller.instance_eval do
        @current_user = company_user
      end
    end
    let(:response) { get :show, params: {_username: user.username} }
    let(:body) { JSON.parse(response.body) }
    it do
      expect(body['id']).to eq(user.id)
      expect(body['name']).to eq(user.name)
      expect(body['username']).to eq(user.username)
      expect(body['email']).to eq(user.email)
    end
  end
  context 'create' do
    let(:params) do
      {
        name: 'usertwo',
        username: 'usertwo',
        email: 'usertwo@mailinator.com',
        password: '123456',
        password_confirmation: '123456'
      }
    end
    let(:response) { post :create, params: params }
    let(:body) { JSON.parse(response.body) }
    it do
      expect(body['name']).to eq(params[:name])
      expect(body['username']).to eq(params[:username])
      expect(body['email']).to eq(params[:email])
    end
  end
end
