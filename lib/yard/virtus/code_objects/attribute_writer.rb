module YARD
  module Virtus
    module CodeObjects
      class AttributeWriter
        attr_reader :attr_name, :type

        # @param [Symbol] attr name of attribute
        # @param [String] type string representation of type in YARD format
        # @param [Boolean] is_private indicates if writer is part of private API
        def initialize(attr, type, is_private=false)
          @attr_name = attr
          @type      = type
          @is_private = is_private
        end

        def method_name
          :"#{attr_name}="
        end

        def yard_method_object(namespace)
          YARD::CodeObjects::MethodObject.new(namespace, method_name, :instance).tap do |mo|
            mo.parameters = [["value", default_value]]
            mo.add_tag param_tag("value", type)
            mo.add_tag private_tag if private?
          end
        end

        protected

        def default_value
          nil
        end

        def private?
          !!@is_private
        end

        def param_tag(param_name, param_type)
          YARD::Tags::Tag.new("param", nil, param_type, param_name)
        end

        def private_tag
          YARD::Tags::Tag.new("private", "")
        end
      end
    end
  end
end
