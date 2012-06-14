require 'twitter-bootstrap-formalwear'
require 'rails/railtie'

class TwitterBootstrapFormalwear::Railtie < Rails::Railtie
  initializer 'twitter-bootstrap-formalwear.initialize',
    :after => :after_initialize do
    ActionView::Base.send :include, TwitterBootstrapFormalwear::FormHelpers
  end
end
