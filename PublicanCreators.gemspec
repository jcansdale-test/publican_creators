# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'PublicanCreators/version'

Gem::Specification.new do |spec|
  spec.name = 'PublicanCreators'
  spec.version = PublicanCreatorsVersion::Version::STRING
  spec.authors = ['Sascha Manns']
  spec.email = ['Sascha.Manns@bdvb.de']

  spec.summary = %q{A short program to fix the publican documentation}
  spec.description = %q{PublicanCreators are a small tool for daily DocBook writers who are using the Redhat publican tool [https://fedorahosted.org/publican/]. PublicanCreators asks after
launching which title, type and environment should be used. Then it starts publican with that settings and works then with the produced files.
It will work inside the Article_Info.xml, Book_Info.xml, TITLE.ent, Author_Group.xml and Revision_History.xml and
will replace the default values with your name, your company, your company_divison and your private or your business
email address, depending on your chosen environment. Also you can set inside your config file that you want to remove
 the Title Logo or the Legal Notice. As a feature it ships a build script for each project.}
  spec.homepage = 'https://github.com/saigkill/PublicanCreators'
  spec.license = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir = 'bin'
  spec.executables = spec.files.grep(%w(PublicanCreators RevisionCreator)) { |f| File.basename(f) }
  spec.require_paths = ['lib']


  spec.platform = Gem::Platform::RUBY
  spec.date = ENV['from'] ? Date.parse(ENV['from']) : Date.today
  spec.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")

  spec.add_development_dependency 'bundler', '~> 1.9', '>= 1.9.6'
  spec.add_development_dependency 'rake', '~> 10.4', '>= 10.4.2'
  spec.add_development_dependency 'rdoc', '~> 4.2', '>= 4.2.0'
  spec.add_development_dependency 'yard', '~> 0.8', '>= 0.8.7.6'
  spec.add_development_dependency 'gem-release', '~> 0.7', '>= 0.7.3'
  spec.add_development_dependency 'coveralls', '~> 0.8', '>= 0.8.1'
  spec.add_development_dependency 'rspec', '~> 3.2', '>= 3.2.0'
  spec.add_development_dependency 'shoulda', '~> 3.5', '>= 3.5.0'
  spec.add_development_dependency 'simplecov', '~> 0.10', '>= 0.10.0'
  spec.add_development_dependency 'cucumber', '~> 2.0', '>= 2.0.0'

  spec.add_runtime_dependency 'dir', '~> 0.1', '>= 0.1.2'
  spec.add_runtime_dependency 'nokogiri', '~> 1.6', '>= 1.6.6.2'
  spec.add_runtime_dependency 'parseconfig', '~> 1.0', '>= 1.0.6'
  spec.add_runtime_dependency 'rainbow', '~> 2.0', '>= 2.0.0'
end

