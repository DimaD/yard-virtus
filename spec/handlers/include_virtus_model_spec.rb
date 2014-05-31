require "spec_helper"

describe VirtusYARD::Handlers::IncludeVirtusModel, type: :handler do
  before(:all) { parse_file! :include_virtus_model_001 }

  it "processes basic model declaration" do
    expect(YARD::Registry.at(:ModelA).instance_mixins).to include(P("Virtus.model"))
  end

  it "processes value object delcaration" do
    expect(YARD::Registry.at(:ModelB).instance_mixins).to include(P("Virtus.value_object"))
  end

  it "processes model declaration with parameters" do
    expect(YARD::Registry.at(:ModelC).instance_mixins).to include(P("Virtus.model"))
  end
end
