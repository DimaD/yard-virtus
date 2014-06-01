require "virtus"
require "yard"

_dir = File.dirname(__FILE__)
require File.join(_dir, "yard", "virtus", "version")

require File.join(_dir, "yard", "virtus", "handlers")
require File.join(_dir, "yard", "virtus", "declarations")
require File.join(_dir, "yard",  "virtus", "code_objects")

# According to ruby conventions if library is called
# `yard-virtus` it should be included via
#
#     require "yard/virtus"
#
# But YARD plugins do not follow this convention and require
# gem names like `yard-*` and being required by the same name.
# Hence this confusing filename.
