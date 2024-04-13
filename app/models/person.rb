class Person < ApplicationRecord
  belongs_to :user, optional: true

  has_many :debts, dependent: :destroy
  has_many :payments, dependent: :destroy

  validates :name, :national_id, presence: true
  validates :national_id, uniqueness: true
  validate :cpf_or_cnpj
  self.per_page = 50

  # def update_balance
  #   update(balance: balance)
  # end

  # TODO: refactor me
  #
  # - improve performance using SQL
  # - sum payments
  # - rename to "balance"

  # def cached_balance (needs to be specified on the person view)
  def update_balance
    update! balance: payments.sum(:amount) - debts.sum(:amount)
    # balance = payments.sum(:amount) - debts.sum(:amount)
    # save!
    # # Rails.cache.fetch "balance_#{id}" do
    # payments.sum(:amount) - debts.sum(:amount)
    # end
  end

  private

  def cpf_or_cnpj
    if !CPF.valid?(national_id) && !CNPJ.valid?(national_id)
      errors.add :national_id, :invalid
    end
  end
end
