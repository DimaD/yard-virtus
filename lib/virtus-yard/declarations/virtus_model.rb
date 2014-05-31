module VirtusYARD
  module Declarations
    # VirtusModel declaration wraps AST which represents
    # inclusion of Virtus and allows to extract useful data
    # like module proxies from it.
    #
    # @example
    #   ast = s(:call, s(:var_ref, s(:const, "Virtus")), :".", s(:ident, "model"))
    #   d   = VirtusModel.new(ast)
    #   d.module_proxies_in_ns(ns) # => P("Virtus.model")
    #
    class VirtusModel
      attr_reader :ast

      # @params [YARD::Parser::Ruby::MethodCallNode] ast
      def initialize(ast)
        @ast = ast
      end

      # @param [YARD::CodeObjects::ClassObject] namespace
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
