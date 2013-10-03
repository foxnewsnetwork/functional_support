# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'functional_support/version'

Gem::Specification.new do |spec|
  spec.name          = "functional_support"
  spec.version       = FunctionalSupport::VERSION
  spec.authors       = ["Thomas Chen"]
  spec.email         = ["foxnewsnetwork@gmail.com"]
  spec.description   = %q{Core extensions on array and hash I find useful for everyday development}
  spec.summary       = %q{Includes a lot of stuff on higher order functional processing of arrays and hashes}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~>2.13"
  spec.add_dependency "activesupport", ">=2.3"
end
