# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'guard/tap/version'

Gem::Specification.new do |spec|
  spec.name          = "guard-tap"
  spec.version       = Guard::TapVersion::VERSION
  spec.authors       = ["hitode909"]
  spec.email         = ["hitode909@gmail.com"]
  spec.description   = %q{Guard::Tap automatically run your tests using TAP(Test Anything Protocol).}
  spec.summary       = %q{Guard gem for Test Anything Protocol)}
  spec.homepage      = "http://github.com/hitode909/guard-tap"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_dependency 'guard', '>= 1.8'

  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'guard-rspec'
end
