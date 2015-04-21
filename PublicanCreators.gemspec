# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'PublicanCreators/version'

Gem::Specification.new do |spec|
  spec.name          = 'PublicanCreators'
  spec.version       = PublicanCreators::VERSION
  spec.authors       = ['Sascha Manns']
  spec.email         = ['Sascha.Manns@xcom.de']

  spec.summary       = %q{A short program to fix the publican documentation}
  spec.description   = %q{This program creates a publican initial documentation from a special brand. Then it modifies the output to our needs.}
  spec.homepage      = 'https://github.com/saigkill/PublicanCreators'
  spec.license       = 'GPL-3'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.9'
  spec.add_development_dependency 'rake', '~> 10.0'

  spec.add_runtime_dependency 'dir', '~> 0.1.2'
  spec.add_runtime_dependency 'nokogiri', '~> 1.6.6.2'
  spec.add_runtime_dependency 'rainbow', '~> 2.0.0'
  #spec.add_runtime_dependency 'pry', '~> 0.10.1'
end
