module YARD
  module Virtus
    module Declarations
      # Type declaration wraps AST which represents type of Virtus attribute.
      # It's job is to translate AST into type string which YARD can understand.
      #
      # @example
      #     # this is AST for `Array[String]`.
      #     ast  = s(:aref, s(:var_ref, s(:const, "Array")),
      #                     s(s(:var_ref, s(:const, "String")), false))
      #
      #     type = YARD::Virtus::Declarations::Type.new(ast)
      #     type.yard_type_string # => "Array<String>"
      class Type
        attr_reader :ast

        # @param [YARD::Parser::Ruby::ReferenceNode, YARD::Parser::Ruby::AstNode] ast
        def initialize(ast)
          @ast = ast
        end

        # Get type string for provided AST.
        #
        # @return [String] if provided AST can be transformed into type
        # @return [nil] if can not transform AST into type string
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
end
