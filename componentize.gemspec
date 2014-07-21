# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'componentize/version'

Gem::Specification.new do |spec|
  spec.name          = 'componentize'
  spec.version       = Componentize::VERSION
  spec.authors       = ['M. George Hansen']
  spec.email         = ['technopolitica@gmail.com']
  spec.summary       = %q{Provides a serializeable model and DSL for defining reusable SASS components}
  spec.homepage      = 'http://github.com/technopolitica/componentize'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'rubytree', '~> 0.9'

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake'
end
