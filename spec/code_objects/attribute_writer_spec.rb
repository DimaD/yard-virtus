require "spec_helper"

describe VirtusYARD::CodeObjects::AttributeWriter do
  subject { described_class.new(:title, "String") }

  it "has #attr_name" do
    expect(subject.attr_name).to eq(:title)
  end

  it "has #type" do
    expect(subject.type).to eq("String")
  end

  it "has #method_name" do
    expect(subject.method_name).to eq(:"title=")
  end

  describe "#yard_method_object" do
    let(:writer)    { described_class.new(:title, "String") }
    let(:namespace) { YARD::CodeObjects::ClassObject.new(nil, "TemporarySpecClass") }

    subject { writer.yard_method_object(namespace) }

    it { expect(subject).to be_instance_of(YARD::CodeObjects::MethodObject) }

    it "is not explicit" do
      expect(subject.is_explicit?).to be_false
    end

    it "has the writer name for attribute" do
      expect(subject.name).to eq(:"title=")
    end

    it "has parameter" do
      expect(subject.parameters).not_to be_empty
    end

    it "has type signature tag for parameter" do
      param_tags = subject.tags(:param).select { |t| t.name == "value" }

      expect(param_tags).not_to be_empty
    end
  end
end
