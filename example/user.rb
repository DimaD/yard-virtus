class User
  include Virtus.model

  attribute :name, String
  attribute :age, Integer

  # User can have work address or home address
  attribute :addresses, Array[Address]
end
