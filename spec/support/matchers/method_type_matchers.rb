RSpec::Matchers.define :have_return_type do |type|
  match do |method_object|
    return_tags = method_object.tags(:return)

    expect(return_tags.size).to be > 0

    expect(return_tags.any? { |tag| tag.types.include?(type) }).to be_true
  end
end
