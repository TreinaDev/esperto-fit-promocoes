class PartnerCompanyEmployeesController < ApplicationController
  def index
    @partner_company = PartnerCompany.find(params[:partner_company_id])
    @partner_company_employees = @partner_company.partner_company_employees
  end
  
  def new
  end

  def create
    @partner_company = PartnerCompany.find(params[:partner_company_id])
    return redirect_to new_partner_company_partner_company_employee_path(@partner_company),
           notice: 'Selecione um arquivo de texto' if !params.key?(:file_content)

    file_content = params[:file_content].read.split("\n")
    file_content.each do |cpf|
      PartnerCompanyEmployee.create!(cpf: cpf, partner_company: @partner_company)
    end
    redirect_to partner_company_partner_company_employees_path(@partner_company),
                notice: "#{file_content.length} CPFs cadastrados com sucesso"
  end
end