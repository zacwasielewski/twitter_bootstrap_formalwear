require 'twitter_bootstrap_formalwear'
require 'rails/railtie'

class TwitterBootstrapFormalwear::Railtie < Rails::Railtie
  initializer 'twitter_bootstrap_formalwear.initialize',
    :after => :after_initialize do
    ActionView::Base.send :include, TwitterBootstrapFormalwear::FormHelpers
  end
end
