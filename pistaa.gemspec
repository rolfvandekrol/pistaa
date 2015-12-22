$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "pistaa/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "pistaa"
  s.version     = Pistaa::VERSION
  s.authors     = ["Rolf van de Krol"]
  s.email       = ["info@rolfvandekrol.nl"]
  s.homepage    = "https://github.com/rolfvandekrol/pistaa"
  s.summary     = "Template extension logic"
  s.description = "Template extension logic"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.5"

  s.add_development_dependency "sqlite3"
end
