# -*- ruby -*-
require 'bundler/gem_tasks'
require 'rubygems'

# encoding: utf-8
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

task :default do
  puts 'Using the default task'
end

# Bundler Task
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts 'Run `bundle install` to install missing gems'
  exit e.status_code
end
require 'rake'

# RSpec Task
require 'rspec/core'
require 'rspec/core/rake_task'
desc 'Does anything with RSpec'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['test/**/*_spec.rb']
end
task :default => :spec

# Coveralls Task
require 'coveralls/rake/task'
Coveralls::RakeTask.new
task :test_with_coveralls => [:spec, 'coveralls:push']

# Yard Task
require 'yard'
desc 'Run yarddoc for the source'
YARD::Rake::YardocTask.new do |t|
  t.files = %w('lib/**/*.rb', '-', 'CHANGELOG.rdoc', 'CODE_OF_CONDUCT.md', 'LICENSE.txt', 'README.rdoc')
end

# vim: syntax=ruby
