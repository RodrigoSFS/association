class DashboardService
  def initialize(user)
    @user = user
  end

  def active_people_pie_chart
    Rails.cache.fetch('active_people_pie_chart', expires_in: 1.hour) do
      {
        active: Person.where(active: true).count,
        inactive: Person.where(active: false).count
      }
    end
  end

  def active_people_ids
    Rails.cache.fetch('active_people_ids', expires_in: 1.hour) do
      Person.where(active: true).select(:id).pluck(:id)
    end
  end

  def total_debts
    Rails.cache.fetch('total_debts', expires_in: 1.hour) do
      Debt.where(person_id: active_people_ids).sum(:amount)
    end
  end

  def total_payments
    Rails.cache.fetch('total_payments', expires_in: 1.hour) do
      Payment.where(person_id: active_people_ids).sum(:amount)
    end
  end

  def balance
    total_payments - total_debts
  end

  def last_debts
    Rails.cache.fetch('last_debts', expires_in: 1.hour) do
      Debt.order(created_at: :desc).limit(10).pluck(:id, :amount)
    end
  end

  def last_payments
    Rails.cache.fetch('last_payments', expires_in: 1.hour) do
      Payment.order(created_at: :desc).limit(10).pluck(:id, :amount)
    end
  end

  def my_people
    Rails.cache.fetch("my_people_#{user.id}", expires_in: 1.hour) do
      Person.where(user: user).order(:created_at).limit(10)
    end
  end

  def people100k
    Rails.cache.fetch('people100k', expires_in: 1.hour) do
      Debt.where("amount > 100000").includes(:person).order(:created_at).limit(10)
    end
  end

  def top_person
    Rails.cache.fetch('top_person', expires_in: 1.hour) do
      people.last
    end
  end

  def bottom_person
    Rails.cache.fetch('bottom_person', expires_in: 1.hour) do
      people.first
    end
  end

  private

  attr_reader :user

  def people
    Rails.cache.fetch('people', expires_in: 1.hour) do
      Person.all.select { |person| person.balance > 0 }.sort_by(&:balance)
    end
  end
end
