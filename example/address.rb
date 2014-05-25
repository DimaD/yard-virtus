class Address
  include Virtus.model

  attribute :street,  String
  attribute :zipcode, String
  attribute :city,    City
end
