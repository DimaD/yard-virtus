module VirtusYARD
  module Declarations
    # Type declaration wraps AST which represents
    # type of Virtus attribute
    #
    # @example
    #   ast = s(:call, s(:var_ref, s(:const, "Virtus")), :".", s(:ident, "model"))
    #   d   = VirtusModel.new(ast)
    #   d.module_proxies_in_ns(ns) # => P("Virtus.model")
    #
    class Type
      attr_reader :ast

      # @params [YARD::Parser::Ruby::ReferenceNode, YARD::Parser::Ruby::AstNode] ast
      def initialize(ast)
        @ast = ast
      end

      def yard_type_string
        if association?(ast)
          yard_type_from_association(ast)
        elsif collection?(ast)
          yard_type_from_collection(ast)
        elsif ast.ref?
          yard_type_from_reference(ast)
        elsif !ast[0].nil?
          Type.new(ast[0]).yard_type_string
        else
          nil
        end
      end

      protected
      def yard_type_from_reference(tree)
        tree.path.join("::")
      end

      def yard_type_from_association(tree)
        collection = tree[0].jump(:var_ref)
        key, value = extract_kv_from_association(ast[1])

        "%s{%s => %s}" % [collection, key, value].map { |type| Type.new(type).yard_type_string }
      end

      def yard_type_from_collection(ast)
        "%s<%s>" % [ast[0], ast[1]].map { |type| Type.new(type).yard_type_string }
      end

      def association?(tree)
        tree.jump(:assoc) != tree
      end

      def collection?(tree)
        tree.type == :aref
      end
      def extract_kv_from_association(tree)
        assoc = tree.jump(:assoc)

        return assoc[0], assoc[1]
      end
    end
  end
end
