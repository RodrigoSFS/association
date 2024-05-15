require 'csv'

class PersonMailer < ApplicationMailer
  def balance_report(user)
    @people = Person.order(:name)

    csv_data = CSV.generate do |csv|
      csv << ['Nome', "Saldo"]
      @people.each do |person|
        csv << [person.name, person.balance]
      end
    end

    attachments["balanco_relatorio.csv"] = { mime_type: 'text/csv', content: csv_data }

    mail to: user.email, subject: 'Relatório enviado para seu e-mail'
  end
end
