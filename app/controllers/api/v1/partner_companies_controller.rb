class Api::V1::PartnerCompaniesController < Api::V1::ApiController
  def search
    return render status: :precondition_failed, json: ['CPF não presente'] unless params.key?(:q)

    return render status: :precondition_failed, json: ['CPF inválido'] unless CPF.valid?(params[:q], strict: true)

    @partner_company_employee = PartnerCompanyEmployee.find_by(cpf: params[:q])
    if @partner_company_employee.blank?
      render json: []
    else
      render json: @partner_company_employee.partner_company.as_json(only: %i[discount name id],
                                                                     methods: :format_discount_duration)
    end
  end
end
