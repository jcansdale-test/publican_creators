require 'coveralls'
require 'simplecov'
require 'fileutils'
Coveralls.wear!

SimpleCov.formatter = Coveralls::SimpleCov::Formatter
SimpleCov.start do
  add_filter '.yardoc'
  add_filter 'config'
  add_filter 'doc'
  add_filter 'docs'
  add_filter 'pkg'
  add_filter 'vendor'
end

require 'lib_spec'
