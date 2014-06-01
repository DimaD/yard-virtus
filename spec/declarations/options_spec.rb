require "spec_helper"

describe YARD::Virtus::Declarations::Options do
  def self.example(src, &block)
    c = context "'#{src}'"
    # We can not generate AST for `:a => 1` so we wrap it into
    # method call like in `attribute :a => 1` and then extract
    # part corresponding to options. AST for wrapped code will look
    # like this:
    #
    #     s(:command,
    #       s(:ident, "attribute"),
    #       s(s(s(:assoc,
    #             s(:symbol_literal, s(:symbol, s(:ident, "a"))),
    #             s(:int, "1"))), false))
    #
    c.let(:ast) { ruby_ast("attribute #{src}")[1] }
    c.class_eval(&block)
  end

  subject { described_class.new(ast) }

  example "" do
    it { expect(subject).to be_empty }
  end

  example ":a => :b" do
    it { expect(subject).not_to be_empty }

    it "has information about key :a" do
      expect(subject[:a]).to eq(:b)
    end
  end

  example "a: :b" do
    it { expect(subject).not_to be_empty }

    it "has information about key :a" do
      expect(subject[:a]).to eq(:b)
    end
  end

  example ":default => lambda { 123 }" do
    it { expect(subject).not_to be_empty }

    it "has information about lambda function" do
      expect(subject[:default]).to be_kind_of(Proc)
    end
  end
end
