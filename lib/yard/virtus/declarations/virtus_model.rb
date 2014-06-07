module YARD
  module Virtus
    module Declarations
      # VirtusModel declaration wraps AST which represents mixin of Virtus.
      # It's job is to provide information about Virtus features mixed-in
      # via Virtus declaration.
      #
      # @example
      #   # This is AST for mixin source of `include Virtus.model`.
      #   ast   = s(:call, s(:var_ref, s(:const, "Virtus")),
      #                    :".",
      #                    s(:ident, "model"))
      #
      #   model = YARD::Virtus::Declarations::VirtusModel.new(ast)
      #   model.module_proxies_in_ns(ns) # => P("Virtus.model")
      class VirtusModel
        attr_reader :ast

        # @param [YARD::Parser::Ruby::MethodCallNode] ast
        def initialize(ast)
          @ast = ast
        end

        # Get list of proxies to modules which document fetaures inherited
        # via mixin.
        #
        # @param [YARD::CodeObjects::ClassObject] namespace
        # @return [Array<YARD::CodeObjects::Proxy>]
        def module_proxies_in_ns(namespace)
          [YARD::CodeObjects::Proxy.new(namespace, mixin_name, :module)]
        end

        protected
        def mixin_name
          "%s.%s" % [ast.namespace, ast.method_name].map(&:source)
        end
      end
    end
  end
end
