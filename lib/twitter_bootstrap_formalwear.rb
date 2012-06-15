require 'action_view'

module TwitterBootstrapFormalwear
  autoload :FormBuilder, 'twitter_bootstrap_formalwear/form_builder'
  autoload :FormHelpers, 'twitter_bootstrap_formalwear/form_helpers'
  autoload :Railtie,     'twitter_bootstrap_formalwear/railtie'
  autoload :VERSION,     'twitter_bootstrap_formalwear/version'
end

TwitterBootstrapFormalwear::Railtie # trigger loading the Railtie
