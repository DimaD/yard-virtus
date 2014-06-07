module YARD
  module Virtus
    module Declarations
      # VirtusModel declaration wraps AST which represents
      # call to `attribute` method.
      # It's job is to provide information which documents attribute.
      class VirtusAttribute
        attr_reader :ast

        # @param [YARD::Parser::Ruby::MethodCallNode] ast
        def initialize(ast)
          @ast = ast
          @options = Options.new(parameters[2])
        end

        def readable?
          true
        end

        def writable?
          true
        end

        # Predicate to check if attribute has private writer.
        def has_private_writer?
          options[:writer] == :private
        end

        # Name of the attribute.
        # @return [Symbol]
        def attr_name
          parameters.first.jump(:ident).first.to_sym
        end

        # Type of the attribute in YARD format.
        # @return [String]
        def type
          Type.new(type_param).yard_type_string
        end

        def attribute_reader
          CodeObjects::AttributeReader.new(attr_name, type)
        end

        def attribute_writer
          CodeObjects::AttributeWriter.new(attr_name, type, has_private_writer?)
        end

        protected
        attr_reader :options

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
end
