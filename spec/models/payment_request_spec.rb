require 'rails_helper'

RSpec.describe PaymentRequest, type: :model do
  context 'validate presence of' do
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:full_name) }
    it { is_expected.to validate_presence_of(:iban) }
  end
  context 'valid iban' do
    let(:user) { create(:user, name: 'userone', username: 'userone', email: 'userone@mailinator.com') }
    subject do
      described_class.new(params)
    end
    context 'valid' do
      let(:params) do
        {
          full_name: 'aaa',
          amount_cents: 10000,
          amount_currency: 'EUR',
          iban: 'GB33BUKB20201555555555',
          user: user
        }
      end
      it { is_expected.to be_valid }
    end
    context 'invalid' do
      let(:params) do
        {
          full_name: 'aaa',
          amount_cents: 10000,
          amount_currency: 'EUR',
          iban: 'GB33BUKB20201555555556'
        }
      end
      it { is_expected.to_not be_valid }
    end
  end
  describe 'associations' do
    it { should belong_to(:user) }
  end
end
