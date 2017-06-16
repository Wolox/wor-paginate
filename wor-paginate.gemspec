$:.push File.expand_path("../lib", __FILE__)

require "wor/paginate/version"

Gem::Specification.new do |s|
  s.name        = "wor-paginate"
  s.version     = Wor::Paginate::VERSION
  s.platform    = Gem::Platform::RUBY
  s.date        = Date.today
  s.authors     = ["hdf1986", "icoluccio", "alanhala"]
  s.email       = ["hugo.farji@wolox.com.ar", "ignacio.coluccio@wolox.com.ar", "alan.halatian@wolox.com.ar"]
  s.homepage    = "https://github.com/Wolox/wor-paginate"
  s.summary     = "Summary of Wor::Paginate."
  s.description = "Description of Wor::Paginate."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.require_paths = ['lib']


  s.add_dependency 'railties', '>= 4.1.0', '< 5.1'

  s.add_development_dependency 'faker'
  s.add_development_dependency 'webmock'
  s.add_development_dependency 'byebug', '~> 9.0'
  s.add_development_dependency 'rubocop', '~> 0.47.0'
  s.add_development_dependency 'bundler', '~> 1.13'
  s.add_development_dependency 'rake', '~> 10.0'
  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'codeclimate-test-reporter', '~> 1.0.0'
  s.add_development_dependency 'generator_spec'
  s.add_development_dependency 'simplecov'
end
