module VirtusYARD
  module Spec
    module ParsingHelpers
      def parser_for(code)
        YARD::Parser::Ruby::RubyParser.new(code, "virtus-yard-spec.rb")
      end

      def ruby_ast(statement)
        parser_for(statement).parse.ast[0]
      end
    end
  end
end
