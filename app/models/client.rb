class Client
  attr_reader :id, :email, :name, :cpf, :company_id

  def initialize(id:, email:, name:, cpf:, company_id:)
    @id = id
    @email = email
    @name = name
    @cpf = cpf
    @company_id = company_id
  end

  def self.where(query)
    response = Faraday.get('https://localhost:4000/api/v1/clients', { company_id: query })
    clients = []
    if response.status == 200
      list = JSON.parse(response.body, symbolize_names: true)
      list.each do |client|
        clients << Client.new(id: client[:id], email: client[:email], name: client[:name], cpf: client[:cpf],
                              company_id: client[:company_id])
      end
    end
    clients
  end
end
