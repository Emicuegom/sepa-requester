require 'rails_helper'

RSpec.describe User, type: :model do
  context '#username' do
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_uniqueness_of(:username) }
  end

  context '#email' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to_not allow_value("blah").for(:email) }
    it { is_expected.to allow_value("a@b.com").for(:email) }
  end
  context '#password' do
    it {is_expected.to validate_length_of(:password).is_at_least(6)}
  end
  describe 'associations' do
    it { should have_many(:payment_requests) }
  end
end
