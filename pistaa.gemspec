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
  s.summary     = "Template extension helper"
  s.description = "Simple structure that allows extending templates from engines."
  s.license     = "MIT"

  s.files = Dir["{app,config,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 4.2.5"
end
