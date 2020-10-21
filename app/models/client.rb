class Client
  attr_reader :id, :email, :name, :cpf, :company_id

  def initialize(**args)
    args.each do |key, value|
      instance_variable_set("@#{key}", value)
    end
    @name = args.dig(:profile, :name)
  end

  def self.where(query)
    response = Faraday.get("#{Rails.configuration.apis[:clients]}/clients",
                           { company: query })
    return [] unless response.status == 200

    list = JSON.parse(response.body, symbolize_names: true)
    list.map do |client|
      Client.new(client)
    end
  end

  def description
    "#{name} - #{cpf} - #{email}"
  end
end
