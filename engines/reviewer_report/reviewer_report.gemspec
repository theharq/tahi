$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "reviewer_report/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "reviewer_report"
  s.version     = ReviewerReport::VERSION
  s.authors     = ["Tahi"]
  s.email       = ["tahi-project@neo.com"]
  s.homepage    = "http://www.tahi.com"
  s.summary     = "Financial disclosure questionnaire"
  s.description = "Financial disclosure questionnaire"
  s.license     = "TBD"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.1.1"

  s.add_development_dependency "sqlite3"
end
