require "spec_helper"

describe YARD::Virtus::Declarations::VirtusAttribute do
  let(:ast) { ruby_ast(declaration) }
  let(:namespace) { YARD::CodeObjects::ClassObject.new(nil, "TemporarySpecClass") }
  let(:subject) { described_class.new(ast) }

  def self.example(src, &block)
    c = context "'#{src}'"
    c.let(:declaration) { src }
    c.class_eval(&block)
  end

  example "attribute :title, String" do
    it { expect(subject).to be_readable }
    it { expect(subject).to be_writable }

    it { expect(subject.attr_name).to eq(:title) }
    it { expect(subject.type).to eq("String") }

    it "produces reader method object" do
      expect(subject.attribute_reader).to be_kind_of(YARD::Virtus::CodeObjects::AttributeReader)
    end

    it "produces writer method object" do
      expect(subject.attribute_writer).to be_kind_of(YARD::Virtus::CodeObjects::AttributeWriter)
    end
  end

  example "attribute :title, Namespaced::String" do
    it { expect(subject).to be_readable }
    it { expect(subject).to be_writable }

    it { expect(subject.attr_name).to eq(:title) }
    it { expect(subject.type).to eq("Namespaced::String") }
  end

  example "attribute :locations, Array[Address]" do
    it { expect(subject).to be_readable }
    it { expect(subject).to be_writable }

    it { expect(subject.attr_name).to eq(:locations) }
    it { expect(subject.type).to eq("Array<Address>") }
  end

  example "attribute :locations, Array[Array[Point]]" do
    it { expect(subject).to be_readable }
    it { expect(subject).to be_writable }

    it { expect(subject.attr_name).to eq(:locations) }
    it { expect(subject.type).to eq("Array<Array<Point>>") }
  end

  example "attribute :locations, Hash[Symbol => Address]" do
    it { expect(subject).to be_readable }
    it { expect(subject).to be_writable }

    it { expect(subject.attr_name).to eq(:locations) }
    it { expect(subject.type).to eq("Hash{Symbol => Address}") }
  end

  example "attribute :unique_id, String, :writer => :private" do
    it { expect(subject).to have_private_writer }
  end

  example "attribute :unique_id, String, writer: :private" do
    it { expect(subject).to have_private_writer }
  end

  example "attribute :unique_id, String, :writer => :private, :a => :b" do
    it { expect(subject).to have_private_writer }
  end
end
