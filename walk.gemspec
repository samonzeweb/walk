# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'walk/version'

Gem::Specification.new do |spec|
  spec.name          = "walk"
  spec.version       = Walk::VERSION
  spec.authors       = ["Samuel GAY"]
  spec.email         = ["sam.onzeweb@gmail.com"]
  spec.summary       = 'Directory tree traversal tool inspired by python os.walk'
  spec.homepage      = "https://bitbucket.org/samonzeweb/walk"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.14"
end
