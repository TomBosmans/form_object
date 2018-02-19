$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "form_object/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "form_object"
  s.version     = FormObject::VERSION
  s.authors     = ["TomBosmans"]
  s.email       = ["t.bosse@hotmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of FormObject."
  s.description = "TODO: Description of FormObject."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.2.0.rc1"

  s.add_development_dependency "sqlite3"
end
