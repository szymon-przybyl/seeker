# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'seeker/version'

Gem::Specification.new do |spec|
  spec.name          = "seeker"
  spec.version       = Seeker::VERSION
  spec.authors       = ["Szymon Przybył"]
  spec.email         = ["szymon@estender.net"]
  spec.description   = %q{This Ruby on Rails gem provides an elegant way to separate search logic out of models.}
  spec.summary       = %q{It separates search indecies setup and search rules to searchers. They also may be used in form helpers just like models.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
