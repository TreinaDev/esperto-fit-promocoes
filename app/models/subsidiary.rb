class Subsidiary
  attr_reader :id, :name, :address, :cep
  
  def initialize(id:, name:, address:, cep:)
    @id = id
    @name = name
    @address = address
    @cep = cep
  end

  def self.all
    [new(id: 1, name: 'Vila Maria', address: 'Avenida Osvaldo Reis, 801', cep: '88306-773'),
    new(id: 2, name: 'Ipiranga', address: 'Rua da Concórdia, 201', cep: '57071-812'),
    new(id: 3, name: 'Santos', address: 'Rua das Hortências, 302', cep: '78150-384')]
  end
end
