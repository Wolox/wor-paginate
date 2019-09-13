lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "wor/paginate/version"
require 'date'

Gem::Specification.new do |s|
  s.name        = "wor-paginate"
  s.version     = Wor::Paginate::VERSION
  s.platform    = Gem::Platform::RUBY
  s.date        = Date.today
  s.authors     = ["icoluccio", "mnmallea", "holywyvern", "lucasVoboril"]
  s.email       = ["ignacio.coluccio@wolox.com.ar", "martin.mallea@wolox.com.ar", "ramiro.rojo@wolox.com.ar", "lucas.voboril@wolox.com.ar"]
  s.homepage    = "https://github.com/Wolox/wor-paginate"
  s.summary     = "Simplified pagination for Rails API controllers"
  s.description = "Wor::Paginate is a gem for Rails that simplifies pagination, particularly for controller methods, while standardizing JSON output for APIs. It's meant to work both as a standalone pagination gem and as an extra layer over Kaminari and will_paginate"
  s.license     = "MIT"

  s.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec)/}) }
  s.require_paths = ['lib']


  s.add_dependency 'railties', '>= 4.1.0', "< 5.3"
  s.add_dependency 'rails', '>= 4.0'
end
