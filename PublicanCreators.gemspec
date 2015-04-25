# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'PublicanCreators/version'

Gem::Specification.new do |spec|
  spec.name = 'PublicanCreators'
  spec.version = PublicanCreatorsVersion::VERSION
  spec.authors = ['Sascha Manns']
  spec.email = ['Sascha.Manns@xcom.de']

  spec.summary = %q{A short program to fix the publican documentation}
  spec.description = %q{This program creates a publican initial documentation from a special brand. Then it modifies the output to our needs.}
  spec.homepage = 'https://github.com/saigkill/PublicanCreators'
  spec.license = 'MIT'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir = 'bin'
  spec.executables = spec.files.grep(%r{^sh/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.9'
  spec.add_development_dependency 'rake', '~> 10.4.2'
  spec.add_development_dependency 'rdoc', '~> 4.2.0'
  spec.add_development_dependency 'yard', '~> 0.8.7.6'
  spec.add_development_dependency 'gem-release', '~> 0.7.3'
  spec.add_development_dependency 'coveralls', '0.8.1'
  spec.add_development_dependency 'rspec', '3.2.0'
  spec.add_development_dependency 'shoulda', '3.5.0'
  spec.add_development_dependency 'simplecov', '0.10.0'

  spec.add_runtime_dependency 'dir', '~> 0.1.2'
  spec.add_runtime_dependency 'nokogiri', '~> 1.6.6.2'
  spec.add_runtime_dependency 'parseconfig', '~> 1.0.6'
end

