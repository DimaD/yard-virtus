# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard :rspec, cmd: "bundle exec rspec" do
  watch(%r{^spec/(.+)/.+_spec\.rb$})

  watch(%r{^lib/yard/virtus/(.+)/(.+)\.rb$}) { |m| "spec/#{m[1]}/#{m[2]}_spec.rb" }

  watch('spec/spec_helper.rb')       { "spec" }
  watch(%r{spec/support/(.+)/*.rb$}) { "spec" }
end
