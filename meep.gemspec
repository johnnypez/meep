# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'meep/version'

Gem::Specification.new do |gem|
  gem.name          = "meep"
  gem.version       = Meep::VERSION
  gem.authors       = ["John Butler"]
  gem.email         = ["john.butler@betapond.com"]
  gem.description   = %q{A client for Google Measurement Protocol https://developers.google.com/analytics/devguides/collection/protocol/v1/reference}
  gem.summary       = %q{A client for Google Measurement Protocol}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'httparty'
  gem.add_development_dependency 'rspec'
end
