RSpec::Matchers.define :define_readable_attribute do |attr_name|
  match do |namespace|
    expect(namespace).to be_kind_of(YARD::CodeObjects::NamespaceObject)

    rname = namespace.to_s + "#" + attr_name.to_s
    reader_object  = YARD::Registry.at(rname)
    attributes_map = namespace.attributes[:instance][attr_name]

    expect(reader_object).to be_instance_of(YARD::CodeObjects::MethodObject)
    expect(attributes_map[:read]).to eq(reader_object)
  end

  description do |attr_name|
    "define readable attribute #{attr_name} in #{namespace.source}"
  end
end

RSpec::Matchers.define :define_writable_attribute do |attr_name|
  match do |namespace|
    expect(namespace).to be_kind_of(YARD::CodeObjects::NamespaceObject)

    wname = namespace.to_s + "#" + attr_name.to_s + "="
    writer_object  = YARD::Registry.at(wname)
    attributes_map = namespace.attributes[:instance][attr_name]

    expect(writer_object).to be_instance_of(YARD::CodeObjects::MethodObject)
    expect(attributes_map[:write]).to eq(writer_object)
  end

  description do
    "define writable attribute #{attr_name}"
  end
end
