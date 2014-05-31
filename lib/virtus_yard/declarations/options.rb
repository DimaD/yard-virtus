module VirtusYARD
  module Declarations
    # VirtusModel declaration wraps AST which represents
    # options hash.
    class Options
      attr_reader :ast

      # @params [YARD::Parser::Ruby::AstNode, nil] ast
      def initialize(ast)
        @ast = ast
        @data = if ast.kind_of?(YARD::Parser::Ruby::AstNode)
                  safe_eval("{#{ast.source}}")
                else
                  {}
                end
      end

      def [](key)
        data[key]
      end

      def empty?
        data.empty?
      end

      protected
      attr_reader :data

      # It's not the best idea to use eval but
      # interpreting AST tree to search for hash
      # values is not fun either.
      # @todo replace with AST tree interpreter
      def safe_eval(source)
        proc do |src|
          $SAFE = 3;
          eval(src)
        end.call(source.untaint)
      end
    end
  end
end
