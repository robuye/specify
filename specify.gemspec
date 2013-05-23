# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'specify/version'

Gem::Specification.new do |gem|
  gem.name          = "specify"
  gem.version       = Specify::VERSION
  gem.authors       = ["Robert Ulejczyk"]
  gem.email         = ["rulejczyk@gmail.com"]
  gem.description   = "Helper methods for defining specifications."
  gem.summary       = "Specification Pattern in Ruby"
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency "pry"
end
