class User
  include Virtus.model

  attribute :name, String
  attribute :age, Integer
  attribute :addresses, Array[Address]
end
