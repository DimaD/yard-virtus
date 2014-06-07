require File.join(File.dirname(__FILE__), "lib", "yard-virtus")
require File.join(File.dirname(__FILE__), "lib", "yard-virtus")
require File.join(File.dirname(__FILE__), "lib", "yard/virtus/mixin_handler_monkey_patch")

desc "Build documentation for sample code set"
YARD::Rake::YardocTask.new("example") do |t|
  t.files   = ["example/**/*.rb"]
  t.options = ["--no-private", "--markup-provider=redcarpet", "--markup=markdown", "--output-dir=./example/doc"]
end
