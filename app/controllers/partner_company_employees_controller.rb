class PartnerCompanyEmployeesController < ApplicationController
  def index
    @partner_company = PartnerCompany.find(params[:partner_company_id])
    @partner_company_employees = @partner_company.partner_company_employees
  end

  def new; end

  def create
    @partner_company = PartnerCompany.find(params[:partner_company_id])

    unless params.key?(:file_content)
      return redirect_to new_partner_company_partner_company_employee_path(@partner_company),
                         notice: t('.attach_text_file')
    end

    file_content = params[:file_content].read.split("\n")

    if file_content.empty?
      return redirect_to new_partner_company_partner_company_employee_path(@partner_company),
                         notice: t('.empty_file')
    end

    invalid_cpfs = @partner_company.add_employee(file_content)

    redirect_to partner_company_partner_company_employees_path(@partner_company),
                notice: success_message(invalid_cpfs, file_content),
                alert: error_message(invalid_cpfs)
  end

  private

  def success_message(invalid_cpfs, total_cpfs)
    "#{total_cpfs.length - invalid_cpfs.length} CPF(s) cadastrado(s) com sucesso"
  end

  def error_message(invalid_cpfs)
    return if invalid_cpfs.empty?

    message = 'CPF(s) inválido(s): '
    invalid_cpfs.each do |cpf|
      message += cpf
      message += ' '
    end
    message
  end
end
