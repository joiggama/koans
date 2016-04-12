# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'koans/version'

Gem::Specification.new do |spec|
  spec.name          = "koans"
  spec.version       = Koans::VERSION
  spec.authors       = ["Ignacio Galindo"]
  spec.email         = ["joiggama@gmail.com"]
  spec.licenses      = ["CC-BY-NC-SA-4.0"]

  spec.summary       = %q{ The legendary ruby koans. }
  spec.homepage      = ""

  spec.files =       []
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "i18n", "~> 0.7.0"
  spec.add_runtime_dependency "rake", "~> 10.5.0"

  spec.add_development_dependency "bundler",     "~> 1.11.2"
  spec.add_development_dependency "guard-rspec", "~> 4.6.5"
  spec.add_development_dependency "rspec",       "~> 3.4.0"
  spec.add_development_dependency "pry-byebug",  "~> 3.3.0"
  spec.add_development_dependency "pry-doc",     "~> 0.8.0"
end
