module YARD
  module Virtus
    module CodeObjects
      class AttributeReader
        attr_reader :attr_name, :type

        # @param [Symbol] attr name of attribute
        # @param [String] type string representation of type in YARD format
        def initialize(attr, type)
          @attr_name = attr
          @type      = type
        end

        def method_name
          attr_name
        end

        def yard_method_object(namespace)
          YARD::CodeObjects::MethodObject.new(namespace, method_name, :instance).tap do |mo|
            mo.add_tag YARD::Tags::Library.new.return_tag("[#{type}]")
          end
        end
      end
    end
  end
end
