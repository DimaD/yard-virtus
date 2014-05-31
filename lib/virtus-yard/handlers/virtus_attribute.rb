module VirtusYARD
  module Handlers
    class VirtusAttribute < YARD::Handlers::Ruby::Base
      handles method_call(:attribute)
      namespace_only

      def process
        raise YARD::Handlers::HandlerAborted unless virtus_model?

        declaration = Declarations::VirtusAttribute.new(statement)


        register_attribute!(declaration.attribute_reader, :read)  if declaration.readable?
        register_attribute!(declaration.attribute_writer, :write) if declaration.writable?
      end

      protected

      # @param [CodeObjects::AttributeReader, CodeObjects::AttributeWriter] mobject
      # @param [YARD::CodeObjects::MethodObject] mobject
      # @param [:read, :write] type
      def register_attribute!(mobject, type)
        yard_mobject = mobject.yard_method_object(namespace)

        register(yard_mobject)
        attributes_data_for(mobject.attr_name)[type] = yard_mobject
      end

      def attributes_data_for(name)
        namespace.attributes[scope][name] ||= SymbolHash[:read => nil, :write => nil]
      end

      def virtus_model?
        namespace[:supports_virtus_attributes] == true
      end
    end
  end
end
