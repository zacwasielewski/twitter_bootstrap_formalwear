require File.expand_path('../lib/twitter_bootstrap_formalwear/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'twitter_bootstrap_formalwear'
  s.version     = TwitterBootstrapFormalwear::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = [ 'Zac Wasielewski' ]
  s.email       = [ 'zac@wasielewski.org' ]
  s.homepage    = 'http://github.com/zacwasielewski/twitter_bootstrap_formalwear'
  s.summary     = 'Rails form builder optimized for Twitter Bootstrap'
  s.description = 'Dress up your Rails forms with Twitter Bootstrap-friendly markup'

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map {|f| f =~ /^bin\/(.*)/ ? $1 : nil }.compact
  s.require_path = 'lib'

  s.add_dependency 'railties',   '~> 3'
  s.add_dependency 'actionpack', '~> 3'
end
