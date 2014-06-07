module YARD
  module Virtus
    module Declarations
      # Options declaration wraps AST which represents
      # options hash.
      #
      # @example
      #     # this is AST for hash part of call `hello :default => 0, :writer => :private`
      #     ast = s(s(:assoc, s(:symbol_literal, s(:symbol, s(:ident, "default"))),
      #                       s(:int, "0")),
      #             s(:assoc, s(:symbol_literal, s(:symbol, s(:ident, "writer"))),
      #                       s(:symbol_literal, s(:symbol, s(:ident, "private")))))
      #     options = YARD::Virtus::Declarations::Options.new(ast)
      #     options[:writer] # => :private
      class Options
        attr_reader :ast

        # @param [YARD::Parser::Ruby::AstNode, nil] ast
        def initialize(ast)
          @ast = ast
          @data = if ast.kind_of?(YARD::Parser::Ruby::AstNode)
                    safe_eval("{#{ast.source}}")
                  else
                    {}
                  end
        end

        # Get option value by key.
        def [](key)
          data[key]
        end

        # Predicate to check if there are any options.
        def empty?
          data.empty?
        end

        protected
        attr_reader :data

        # It's not the best idea to use eval but interpreting AST tree to search for hash
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
end
