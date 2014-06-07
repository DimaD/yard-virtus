# Standard YARD mixin handler can not process mixins which include method call.
# It throws UndocumentableError when it encounters any virtus mixin because they
# all include method call:
#
#     [warn]: in YARD::Handlers::Ruby::MixinHandler: Undocumentable mixin: YARD::Parser::UndocumentableError for class City
#     [warn]:   in file 'example/city.rb':2:
#
#           2: include Virtus.model
#
# This monkey patch aborts parsing of statement instead of raising UndocumentableError.
class YARD::Handlers::Ruby::MixinHandler < YARD::Handlers::Ruby::Base
  protected
  alias_method :original_process_mixin, :process_mixin

  def process_mixin(mixin)
    raise YARD::Handlers::HandlerAborted if virtus_module?(mixin)

    original_process_mixin(mixin)
  end

  def virtus_module?(mixin)
    included_module = mixin.jump(:var_ref)
    included_module and included_module.source == "Virtus"
  end
end
