# coding: utf-8

lib = File.expand_path '../lib', __FILE__

$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include? lib

require 'omniauth-chef/version'

Gem::Specification.new do |spec|
  spec.name        = 'omniauth-chef'
  spec.version     = OmniAuth::Chef::VERSION
  spec.authors     = ['James Casey', 'Allen Goodman']
  spec.email       = %q(james@getchef.com a@getchef.com)
  spec.description = %q{OmniAuth strategy for Chef}
  spec.summary     = %q{OmniAuth strategy for Chef}
  spec.homepage    = 'https://github.com/opscode/oc_actionlog'
  spec.license     = 'Apache-2.0'

  spec.files  = %w(.gitignore omniauth-chef.gemspec Gemfile Rakefile)
  spec.files += Dir.glob 'lib/**/*.rb'
  spec.files += Dir.glob 'bin/**/*'

  spec.test_files = Dir.glob 'spec/**/*.rb'

  spec.require_paths = %w(lib)

  spec.add_development_dependency 'guard-rspec', '~>  4.2'
  spec.add_development_dependency 'rack-test',   '~> 1'
  spec.add_development_dependency 'rake',        '~> 13'
  spec.add_development_dependency 'rspec',       '~> 3'

  spec.add_runtime_dependency 'chef',     '~> 16'
  spec.add_runtime_dependency 'omniauth', '~> 2.0', '>= 2.0.4' # required for CVE-2015-9284
end
