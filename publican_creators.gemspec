# frozen_string_literal: true
$LOAD_PATH.unshift File.expand_path('lib', __dir__)
require_relative 'lib/publican_creators/version'
require 'rubygems'

# rubocop:disable Metrics/BlockLength
Gem::Specification.new do |s|
  s.name = 'publican_creators'
  s.version = PublicanCreators::Version::STRING
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.3.0'
  s.authors = ['Sascha Manns']
  s.description = <<-DESCRIPTION
    publican_creators are a small tool for daily DocBook writers who are using the Redhat publican tool
    https://fedorahosted.org/publican/.
  DESCRIPTION

  s.email = 'Sascha.Manns@outlook.de'
  s.files = `git ls-files bin data etc lib CONTRIBUTING.md CHANGELOG.md LICENSE.md MAINTENANCE.md README.md`
                .split($RS)
  s.bindir = 'bin'
  s.executables = ['publican_creators.rb', 'revision_creator.rb']
  s.extra_rdoc_files = ['CHANGELOG.md', 'LICENSE.md', 'MAINTENANCE.md', 'README.md']
  s.homepage = 'https://github.com/saigkill/publican_creators'
  s.licenses = ['GPL-3.0']
  s.summary = 'Small tool for daily DocBook writers'

  s.metadata = {
      'homepage_uri' => 'https://github.com/saigkill/publican_creators',
      'changelog_uri' => 'https://github.com/saigkill/publican_creators/blob/master/CHANGELOG.md',
      'source_code_uri' => 'https://github.com/saigkill/publican_creators',
      'documentation_uri' => 'https://saschamanns.de/docs/publican_creators/index.html',
      'bug_tracker_uri' => 'https://github.com/saigkill/publican_creators/issues'
  }

  s.add_runtime_dependency('rdoc', '~> 6.1')
  s.add_runtime_dependency('rake', '~> 12.3')
  s.add_runtime_dependency('rainbow', '~> 3.0')
  s.add_runtime_dependency('bundler', '~> 2.0.1')
  s.add_runtime_dependency('parseconfig', '~> 1.0')
  s.add_runtime_dependency('rspec', '~> 3.8')
  s.add_runtime_dependency('xdg', '~> 2.2')
  s.add_runtime_dependency('nokogiri', '~> 1.10')
  s.add_runtime_dependency('combine_pdf', '~> 1.0')
  s.add_runtime_dependency('pony', '~> 1')
  s.add_runtime_dependency('notifier', '~> 0.5')
  s.add_runtime_dependency('coveralls', '~> 0.8')
  s.add_runtime_dependency('rubocop', '~> 0.68')
end

# rubocop:enable Metrics/BlockLength