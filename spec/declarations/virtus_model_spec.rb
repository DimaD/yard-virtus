require "spec_helper"

describe VirtusYARD::Declarations::VirtusModel do
  let(:ast) { ruby_ast(declaration) }
  let(:namespace) { YARD::CodeObjects::ClassObject.new(nil, "TemporarySpecClass") }
  let(:subject) { described_class.new(ast) }

  context "when declaration is 'Virtus.model'" do
    let(:declaration) { "Virtus.model" }

    it "has one module proxy" do
      expect(subject.module_proxies_in_ns(namespace)).to have(1).item
    end

    it "has module proxy for Virtus.model" do
      expect(subject.module_proxies_in_ns(namespace)).to include(P("Virtus.model"))
    end
  end

  context "when declaration is 'Virtus.value_object'" do
    let(:declaration) { "Virtus.value_object" }

    it "has module proxy for Virtus.value_object" do
      expect(subject.module_proxies_in_ns(namespace)).to include(P("Virtus.value_object"))
    end
  end

  context "when declaration is 'Virtus.model(mass_assignmet: false)'" do
    let(:declaration) { "Virtus.model(mass_assignment: false)" }

    it "has module proxy for Virtus.model" do
      expect(subject.module_proxies_in_ns(namespace)).to include(P("Virtus.model"))
    end
  end
end
