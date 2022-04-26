class PaymentRequest < ApplicationRecord
  enum status: {new: 0, processing: 1, done: 2}, _prefix: :status
  validates :user, presence: true
  validates :full_name, presence: true
  validates :iban, presence: true
  validate :valid_iban?
  belongs_to :user
  monetize :amount_cents, with_model_currency: :amount_currency

  private

  def valid_iban?
    return if IBANTools::IBAN.valid?(iban)
    errors.add(:iban, 'Invalid iban')
  end
end
