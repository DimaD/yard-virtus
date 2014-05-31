# @example
#   expect(YARD::Registry.at("User#friends")).to have_return_type("Array<User>")
RSpec::Matchers.define :have_return_type do |yard_type_string|
  match do |method_object|
    return_tags = method_object.tags(:return)

    expect(return_tags.size).to be > 0

    expect(return_tags.any? { |tag| tag.types.include?(yard_type_string) }).to be_true
  end
end
