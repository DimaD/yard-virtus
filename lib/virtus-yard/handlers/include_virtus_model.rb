module VirtusYARD
  module Handlers
    class IncludeVirtusModel < YARD::Handlers::Ruby::Base
      handles method_call(:include)
      namespace_only

      def process
        raise YARD::Handlers::HandlerAborted unless virtus_module?

        declaration = Declarations::VirtusModel.new(virtus_call)
        declaration.module_proxies_in_ns(namespace).each do |proxy|
          namespace.mixins(scope).unshift(proxy)
        end
      end

      protected

      def virtus_module?
        included_module = statement.parameters.jump(:var_ref)
        included_module and included_module.source == "Virtus"
      end

      def virtus_call
        statement.parameters(false)[0]
      end
    end
  end
end
