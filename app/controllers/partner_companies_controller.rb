class PartnerCompaniesController < ApplicationController
  before_action :authenticate_user!, only: %i[index show new]

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
    @partner_company.user = current_user
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
