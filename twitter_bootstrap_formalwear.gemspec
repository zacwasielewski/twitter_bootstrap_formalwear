$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "twitter_bootstrap_formalwear/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "twitter_bootstrap_formalwear"
  s.version     = TwitterBootstrapFormalwear::VERSION
  s.authors     = ["Zac Wasielewski"]
  s.email       = ["zac@wasielewski.org"]
  s.homepage    = 'http://github.com/zacwasielewski/twitter_bootstrap_formalwear'
  s.summary     = 'Rails form helper optimized for Twitter Bootstrap'
  s.description = 'Dress up your Rails forms with Twitter Bootstrap markup'

  s.files = Dir["{app,config,db,lib}/**/*"] + ["LICENSE.markdown", "Rakefile", "README.markdown"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.3"

  s.add_development_dependency "sqlite3"
end
