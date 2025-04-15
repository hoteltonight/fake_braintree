# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'fake_braintree/version'

Gem::Specification.new do |s|
  s.name        = 'fake_braintree'
  s.version     = FakeBraintree::VERSION
  s.authors     = ['thoughtbot, inc.']
  s.email       = ['gabe@thoughtbot.com', 'ben@thoughtbot.com']
  s.homepage    = ''
  s.summary     = %q{A fake Braintree that you can run integration tests against}
  s.description = %q{A fake Braintree that you can run integration tests against}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']
  s.required_ruby_version = Gem::Requirement.new(">= 3.1.0")

  s.add_dependency 'activesupport', '~> 6.1.7'
  s.add_dependency 'braintree', '~> 4.26.0'
  s.add_dependency 'capybara', '>= 3.33.0'
  s.add_dependency 'sinatra', '~> 3.0.5'
  s.add_dependency 'puma', '~> 5.6.7'

  s.add_development_dependency 'rake', '~> 13.2.1'
  s.add_development_dependency 'rspec', '~> 3.10'
  s.add_development_dependency 'timecop', '~> 0.9'
  s.add_development_dependency 'apparition'
end
