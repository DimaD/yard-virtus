module YARD
  module Virtus
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

          register_preserving_tags!(yard_mobject)
          attributes_data_for(mobject.attr_name)[type] = yard_mobject
        end

        def attributes_data_for(name)
          namespace.attributes[scope][name] ||= SymbolHash[:read => nil, :write => nil]
        end

        def virtus_model?
          namespace[:supports_virtus_attributes] == true
        end

        # When you register an object it can get assigned docstring which
        # followed statement which was handled. If such a docstring exists it
        # can result in removal of previously extracted tags like `@return` and
        # `@private` as well as default values. To prevent it we restore all
        # tags which disappeared after registration.
        #
        # Do you love uncontrolled mutations as much as I do?
        def register_preserving_tags!(object)
          tags_before_registration = object.tags

          register(object)

          lost_tags = tags_before_registration - object.tags
          if lost_tags.size > 0
            object.add_tag(*lost_tags)
          end
        end
      end
    end
  end
end
