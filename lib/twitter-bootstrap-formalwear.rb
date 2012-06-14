require 'action_view'

module TwitterBootstrapFormalwear
  autoload :FormBuilder, 'twitter-bootstrap-formalwear/form_builder'
  autoload :FormHelpers, 'twitter-bootstrap-formalwear/form_helpers'
  autoload :Railtie,     'twitter-bootstrap-formalwear/railtie'
  autoload :VERSION,     'twitter-bootstrap-formalwear/version'
end

TwitterBootstrapFormalwear::Railtie # trigger loading the Railtie
