require "spec_helper"

describe VirtusYARD::Declarations::Type do
  def self.example(src, &block)
    c = context "'#{src}'"
    c.let(:ast) { ruby_ast(src) }
    c.class_eval(&block)
  end

  describe "#yard_type_string" do
    let(:subject) { described_class.new(ast).yard_type_string }

    example "String" do
      it { expect(subject).to eq "String" }
    end

    example "Some::Nested::String" do
      it { expect(subject).to eq "Some::Nested::String" }
    end

    example "Array[String]" do
      it { expect(subject).to eq "Array<String>" }
    end

    example "Array[Nested::String]" do
      it { expect(subject).to eq "Array<Nested::String>" }
    end

    example "Collection[Address]" do
      it { expect(subject).to eq "Collection<Address>" }
    end

    example "Hash[String => Integer]" do
      it { expect(subject).to eq "Hash{String => Integer}" }
    end
  end
end
