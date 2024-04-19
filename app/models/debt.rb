class Debt < ApplicationRecord
  belongs_to :person
  self.per_page = 50

  validates :amount, presence: true

  after_save :update_person_balance

  def update_person_balance
    person.update_balance
  end

  # Implementacao da alternativa em cache ao invés de criar uma coluna do banco
  # def update_person_balance
  #   person.clear_balance_cache
  # end
end
