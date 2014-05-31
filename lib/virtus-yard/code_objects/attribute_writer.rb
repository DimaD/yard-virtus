module VirtusYARD
  module CodeObjects
    class AttributeWriter
      attr_reader :attr_name, :type

      # @param [Symbol] attr name of attribute
      # @param [String] type string representation of type in YARD format
      def initialize(attr, type)
        @attr_name = attr
        @type      = type
      end

      def method_name
        :"#{attr_name}="
      end

      def yard_method_object(namespace)
        YARD::CodeObjects::MethodObject.new(namespace, method_name, :instance).tap do |mo|
          mo.parameters = [["value", default_value]]
          mo.add_tag YARD::Tags::Tag.new("param", nil, type, "value")
        end
      end

      protected

      def default_value
        nil
      end
    end
  end
end
