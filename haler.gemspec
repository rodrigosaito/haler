# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'haler/version'

Gem::Specification.new do |gem|
  gem.name          = "haler"
  gem.version       = Haler::VERSION
  gem.authors       = ["Rodrigo Saito"]
  gem.email         = ["rodrigo.saito@gmail.com"]
  gem.description   = %q{Gem used to generate HAL json from objects}
  gem.summary       = %q{Gem used to generate HAL json from objects}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'activesupport'
end
