require "spec_helper"

describe VirtusYARD::CodeObjects::AttributeWriter do
  before :each do
    # All YARD::CodeObjects::* objects are added to
    # registry on creation which causes conflicts in
    # this test.
    YARD::Registry.clear
  end

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

    context "when writer visibility is not specified" do
      let(:writer) { described_class.new(:title, "String") }

      it "does not have @private tag" do
        expect(subject.tags(:private)).to be_empty
      end
    end

    context "when writer is public" do
      let(:writer) { described_class.new(:title, "String", false) }

      it "does not have @private tag" do
        expect(subject.tags(:private)).to be_empty
      end
    end

    context "when writer is private" do
      let(:writer) { described_class.new(:title, "String", true) }

      it "has @private tag" do
        expect(subject.tags(:private)).to have(1).item
      end
    end
  end
end
