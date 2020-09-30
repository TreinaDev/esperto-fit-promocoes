class PartnerCompaniesController < ApplicationController
  def index
    @partner_companies = PartnerCompany.all
  end

  def show
    @partner_company = PartnerCompany.find(params[:id])
  end

  def new
    @partner_company = PartnerCompany.new
  end

  def create
    @partner_company = PartnerCompany.new(partner_company_params)
    if @partner_company.save
      redirect_to @partner_company, notice: 'Empresa cadastrada com sucesso'
    else
      render :new
    end
  end

  private

  def partner_company_params
    params.require(:partner_company)
          .permit(:name, :cnpj, :address, :email)
  end
end
