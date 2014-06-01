require "spec_helper"

describe YARD::Virtus::CodeObjects::AttributeReader do
  subject { described_class.new(:title, "String") }

  it "has #attr_name" do
    expect(subject.attr_name).to eq(:title)
  end

  it "has #type" do
    expect(subject.type).to eq("String")
  end

  it "has #method_name" do
    expect(subject.method_name).to eq(:title)
  end

  describe "#yard_method_object" do
    let(:reader)    { described_class.new(:title, "String") }
    let(:namespace) { YARD::CodeObjects::ClassObject.new(nil, "TemporarySpecClass") }

    subject { reader.yard_method_object(namespace) }

    it { expect(subject).to be_instance_of(YARD::CodeObjects::MethodObject) }

    it "is not explicit" do
      expect(subject.is_explicit?).to be_false
    end

    it "has the same name as attribute it reads" do
      expect(subject.name).to eq(:title)
    end

    it "has @return tag" do
      expect(subject.has_tag?(:return)).to be_true
    end
  end
end
