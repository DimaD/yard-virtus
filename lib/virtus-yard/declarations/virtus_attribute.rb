module VirtusYARD
  module Declarations
    # VirtusModel declaration wraps AST which represents
    # call to `attribute` method
    class VirtusAttribute
      attr_reader :ast

      # @params [YARD::Parser::Ruby::MethodCallNode] ast
      def initialize(ast)
        @ast = ast
      end

      def readable?
        true
      end

      def writable?
        true
      end

      def attr_name
        parameters.first.jump(:ident).first.to_sym
      end

      def attribute_reader
        CodeObjects::AttributeReader.new(attr_name, type)
      end

      def attribute_writer
        CodeObjects::AttributeWriter.new(attr_name, type)
      end

      def type
        Type.new(type_param).yard_type_string
      end

      # @param [YARD::CodeObjects::NamespaceObject] namespace
      def method_object_in_ns(namespace)
        YARD::CodeObjects::MethodObject.new(namespace, attr_name, :instance)
      end

      protected

      def parameters
        ast.parameters(false)
      end

      def type_param
        parameters[1]
      end

      def scalar_type_to_string(ref)
        ref.path.join("::")
      end

      def collection_type_to_string(type)
        collection_type = scalar_type_to_string(type_param[0])
        element_type    = scalar_type_to_string(type_param[1].jump(:var_ref))

        "#{collection_type}<#{element_type}>"
      end
    end
  end
end
