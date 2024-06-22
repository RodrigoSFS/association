class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @dashboard_service = DashboardService.new(current_user)

    @active_people_pie_chart = @dashboard_service.active_people_pie_chart
    @total_debts = @dashboard_service.total_debts
    @total_payments = @dashboard_service.total_payments
    @balance = @dashboard_service.balance
    @last_debts = @dashboard_service.last_debts
    @last_payments = @dashboard_service.last_payments
    @my_people = @dashboard_service.my_people
    @top_person = @dashboard_service.top_person
    @bottom_person = @dashboard_service.bottom_person
    @people100k = @dashboard_service.people100k
  end
end
