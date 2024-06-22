class DashboardService
  def initialize(user)
    @user = user
  end

  def active_people_pie_chart
    {
      active: Person.where(active: true).count,
      inactive: Person.where(active: false).count
    }
  end

  def active_people_ids
    Person.where(active: true).select(:id)
  end

  def total_debts
    Debt.where(person_id: active_people_ids).sum(:amount)
  end

  def total_payments
    Payment.where(person_id: active_people_ids).sum(:amount)
  end

  def balance
    total_payments - total_debts
  end

  # no formato somente id + amount para o kickchart
  def last_debts
    Debt.order(created_at: :desc).limit(10).map do |debt|
      [debt.id, debt.amount]
    end
  end

  def last_payments
    Payment.order(created_at: :desc).limit(10).map do |payment|
      [payment.id, payment.amount]
    end
  end

  def my_people
    Person.where(user: user).order(:created_at).limit(10)
  end

  def people100k
    Debt.where("amount > 100000").includes(:person).order(:created_at).limit(10)
  end

  # O banco sempre é mais rápido:
  # @top_person = Person.where('balance > 0').order(:balance).last

  def people
    people = Person.all.select do |person|
    person.balance > 0
    end.sort_by do |person|
      person.balance
    end
  end

  def top_person
    people.last
  end

  def bottom_person
    people.first
  end

  private

  attr_reader :user
end
