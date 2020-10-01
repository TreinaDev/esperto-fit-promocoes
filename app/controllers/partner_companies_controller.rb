class PartnerCompaniesController < ApplicationController
  before_action :authenticate_user!, only: %i[index show new create]

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
    @partner_company = current_user.build_partner_company(partner_company_params)
    @partner_company.discount_duration = nil if  @partner_company.discount_duration_undefined?
    return redirect_to @partner_company, notice: t('.successfull') if @partner_company.save

    render :new
  end

  private

  def partner_company_params
    params.require(:partner_company)
          .permit(:name, :cnpj, :address, :email,
                  :discount_duration, :discount, :discount_duration_undefined)
  end
end
