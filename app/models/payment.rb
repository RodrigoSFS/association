class Payment < ApplicationRecord
  belongs_to :person
  self.per_page = 50

  validates :amount, presence: true
end
