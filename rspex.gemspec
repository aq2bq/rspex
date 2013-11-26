# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rspex/version'

Gem::Specification.new do |spec|
  spec.name          = "rspex"
  spec.version       = RSpex::VERSION
  spec.authors       = ["@aq2bq"]
  spec.email         = ["terada@yukashikado.co.jp"]
  spec.description   = %q{Learn how to writing spec in English from local gem's spec-files}
  spec.summary       = %q{Learn how to writing spec in English from local gem's spec-files}
  spec.homepage      = "https://twitter.com/aq2bq"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_dependency 'thor'
end
