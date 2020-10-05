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
                         notice: 'Selecione um arquivo de texto'
    end

    file_content = params[:file_content].read.split("\n")

    if file_content.empty?
      return redirect_to new_partner_company_partner_company_employee_path(@partner_company),
                         notice: 'Arquivo vazio. Selecione arquivo com conteúdo'
    end

    invalid_cpfs = []
    file_content.each do |cpf|
      @partner_company_employee = PartnerCompanyEmployee.new(cpf: cpf.strip, partner_company: @partner_company)

      next if @partner_company_employee.save

      invalid_cpfs << cpf.strip
    end

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
