require "stringio"

_dir = File.dirname(__FILE__)

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.join(_dir, "support", "**", "*.rb")].each do |f|
  require f
end

require File.join(_dir, "..", "lib", "virtus-yard")

# The global {YARD::Logger} instance
#
# @return [YARD::Logger] the global {YARD::Logger} instance
# @see YARD::Logger
def log
  YARD::Logger.instance
end

# Shortcut for creating a YARD::CodeObjects::Proxy via a path
#
# @see YARD::CodeObjects::Proxy
# @see YARD::Registry.resolve
def P(namespace, name = nil, type = nil)
  namespace, name = nil, namespace if name.nil?
  YARD::Registry.resolve(namespace, name, false, true, type)
end

RSpec.configure do |config|
  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  config.include VirtusYARD::Spec::HandlerHelpers, :type => :handler
  config.include VirtusYARD::Spec::ParsingHelpers

  config.before(:each) { log.io = StringIO.new }
end

def parse_file!(file, thisfile = __FILE__, log_level = log.level, ext = '.rb.txt')
  YARD::Registry.clear
  path = File.join(File.dirname(thisfile), 'examples', file.to_s + ext)
  YARD::Parser::SourceParser.parse(path, [], log_level)
end

class StubbedProcessor < YARD::Handlers::Processor
  def process(statements)
    statements.each_with_index do |stmt, index|
      find_handlers(stmt).each do |handler|
        handler.new(self, stmt).process
      end
    end
  end
end

class StubbedSourceParser < YARD::Parser::SourceParser
  StubbedSourceParser.parser_type = :ruby
  def post_process
    post = StubbedProcessor.new(self)
    post.process(@parser.enumerator)
  end
end

def with_parser(parser_type, &block)
  tmp = StubbedSourceParser.parser_type
  StubbedSourceParser.parser_type = parser_type
  yield
  StubbedSourceParser.parser_type = tmp
end
