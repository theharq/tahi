$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "video_card/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "video_card"
  s.version     = VideoCard::VERSION
  s.authors     = ["Tahi"]
  s.email       = ["tahiprojectteam@plos.org"]
  s.homepage    = "http://www.tahi.com"
  s.summary     = "VideoCard."
  s.description = "Description of VideoCard."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.1.1"

  s.add_development_dependency "sqlite3"

  s.add_development_dependency "rspec-rails"
end
