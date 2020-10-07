class PartnerCompanyEmployeesController < ApplicationController
  before_action :authenticate_user!, only: %i[index new remove_form]
  before_action :must_attach_file, only: %i[create remove_cpfs]
  before_action :file_must_have_content, only: %i[create remove_cpfs]

  def index
    @partner_company = PartnerCompany.find(params[:partner_company_id])
    @partner_company_employees = @partner_company.partner_company_employees
  end

  def new; end

  def create
    invalid_cpfs = @partner_company.add_employee(@file_content)

    redirect_to partner_company_partner_company_employees_path(@partner_company),
                notice: add_success_message(invalid_cpfs, @file_content),
                alert: error_message(invalid_cpfs)
  end

  def remove_form; end

  def remove_cpfs
    invalid_cpfs = @partner_company.remove_employee(@file_content)

    redirect_to partner_company_partner_company_employees_path(@partner_company),
                notice: remove_success_message(invalid_cpfs, @file_content),
                alert: error_message(invalid_cpfs)
  end

  private

  def add_success_message(invalid_cpfs, total_cpfs)
    "#{total_cpfs.length - invalid_cpfs.length} CPF(s) cadastrado(s) com sucesso"
  end

  def remove_success_message(invalid_cpfs, total_cpfs)
    "#{total_cpfs.length - invalid_cpfs.length} CPF(s) removido(s) com sucesso"
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

  def must_attach_file
    @partner_company = PartnerCompany.find(params[:partner_company_id])
    return if params.key?(:file_content)

    redirect_to new_partner_company_partner_company_employee_path(@partner_company),
                notice: t('.attach_text_file')
  end

  def file_must_have_content
    @partner_company = PartnerCompany.find(params[:partner_company_id])
    @file_content = params[:file_content].read.split(/[\r\n]+/)
    return unless @file_content.empty?

    redirect_to new_partner_company_partner_company_employee_path(@partner_company),
                notice: t('.empty_file')
  end
end
