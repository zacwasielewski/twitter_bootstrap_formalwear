require 'twitter_bootstrap_formalwear'
require 'action_view/helpers'

class TwitterBootstrapFormalwear::FormBuilder < ActionView::Helpers::FormBuilder
  include TwitterBootstrapFormalwear::FormHelpers

  attr_reader :template
  attr_reader :object
  attr_reader :object_name

  INPUTS = [
    :check_box,
    :radio_button,
    :select,
    *ActionView::Helpers::FormBuilder.instance_methods.grep(%r{
      _(area|field|select)$ # all area, field, and select methods
    }mx).map(&:to_sym)
  ]

  INPUTS.delete(:hidden_field)

  #TOGGLES = [
  #  :check_box,
  #  :radio_button,
  #]

  #
  # Wraps the contents of the block passed in a fieldset with optional
  # +legend+ text.
  #
  def fieldset(legend = nil, options = {})
    template.content_tag(:fieldset, options) do
      template.concat template.content_tag(:legend, legend) unless legend.nil?
      yield
    end
  end

  #
  # Wraps action buttons into their own styled container.
  #
  def actions(&block)
    template.content_tag(:div, :class => 'form-actions', &block)
  end

  #
  # Generates a control-group div element for the given +attribute+,
  # containing label and controls elements.
  #
  def group(attribute = '', text = '', options = {}, &block)
    text, attribute = attribute, nil if attribute.kind_of? String

    id      = _wrapper_id      attribute, 'control_group'
    classes = _wrapper_classes attribute, 'control-group'

    template.content_tag(:div, :id => id, :class => classes) do
      if !attribute.blank?
        template.concat self.label(attribute, text, options, &block)
      end
      template.concat self.controls(attribute, text, options, &block)
    end
  end
  
  #
  # Generates a control-group div element for the given collection_select +attribute+,
  # containing label and controls elements.
  #
  def group_for_collection_select(attribute = '', text = '', choices = {}, value_method = '', text_method = '', options = {}, &block)
    text, attribute = attribute, nil if attribute.kind_of? String

    id      = _wrapper_id      attribute, 'control_group'
    classes = _wrapper_classes attribute, 'control-group'

    template.content_tag(:div, :id => id, :class => classes) do
      if !attribute.blank?
        template.concat self.label(attribute, text, options, &block)
      end
      template.concat self.controls_for_collection_select(attribute, text, choices, value_method, text_method, options, &block)
    end
  end

  #
  # Generates a label element for the given +attribute+. If +text+ is passed, uses
  # that as the text for the label; otherwise humanizes the +attribute+ name.
  #
  def label(attribute, text = '', options = {}, &block)
    text, attribute = attribute, nil if attribute.kind_of? String

    options = options.merge(:class => 'control-label')

    case
      when attribute && text then super(attribute, text, options, &nil)
      when attribute         then super(attribute, nil,  options, &nil)
      when text              then template.label_tag(nil, text, options, &nil)
    end
  end

  #
  # Generates a controls div element for the given +attribute+.
  #
  def controls(attribute, text = '', options = {}, &block)
    text, attribute = attribute, nil if attribute.kind_of? String

    template.content_tag(:div, :class => 'controls') {
      template.fields_for(
        self.object_name,
        self.object,
        self.options.merge(:builder => TwitterBootstrapFormalwear::FormControls),
        &block
      )
    }
  end

  #
  # Generates a controls div element for the given +attribute+.
  #
  def controls_for_collection_select(attribute, text = '', choices = {}, value_method = '', text_method = '', options = {}, &block)
    text, attribute = attribute, nil if attribute.kind_of? String

    template.content_tag(:div, :class => 'controls') {
      template.fields_for(
        self.object_name,
        self.object,
        self.options.merge(:builder => TwitterBootstrapFormalwear::FormControls),
        &block
      )
    }
  end

  #
  # Generates a controls div element for the given +attribute+.
  #
  def collection_select_controls(attribute, text = '', choices = {}, value_method = '', text_method = '', options = {}, &block)
    text, attribute = attribute, nil if attribute.kind_of? String

    template.content_tag(:div, :class => 'controls') {
      template.fields_for(
        self.object_name,
        self.object,
        self.options.merge(:builder => TwitterBootstrapFormalwear::FormControls),
        &block
      )
    }
  end

  #
  # Renders a button with default classes to style it as a form button.
  #
  def button(value = nil, options = {})
    super value, {
      :type  => 'button',
      :class => 'btn',
    }.merge(options)
  end

  #
  # Renders a submit tag with default classes to style it as a primary form
  # button.
  #
  def submit(value = nil, options = {})
    self.button value, {
      :type  => 'submit',
      :class => 'btn btn-primary',
    }.merge(options)
  end

  INPUTS.each do |input|
  
    case input.to_s
    when 'collection_select'
        define_method input.to_s + '_group' do |attribute, choices, value_method, text_method, *args, &block|
        
          options = args.extract_options!
          text    = args.any? ? args.shift : ''
    
          self.group_for_collection_select(attribute, text, choices, value_method, text_method, options) do |builder|
            builder.send(input, attribute, choices, value_method, text_method, *(args << options), &block)
          end
        end
    
        define_method input.to_s + '_label' do |attribute, *args, &block|
          options = args.extract_options!
          text    = args.any? ? args.shift : ''
    
          self.label(attribute, text, options) do |builder|
            builder.send(input, attribute, *(args << options), &block)
          end
        end
    
        define_method input.to_s + '_controls' do |attribute, choices, value_method, text_method, *args, &block|
          options = args.extract_options!
          text    = args.any? ? args.shift : ''
    
          self.controls_for_collection_select(attribute, text, choices, value_method, text_method, options) do |builder|
            builder.send(input, attribute, choices, value_method, text_method, *(args << options), &block)
          end
        end
    else
        define_method input.to_s + '_group' do |attribute, *args, &block|
          options = args.extract_options!
          text    = args.any? ? args.shift : ''
    
          self.group(attribute, text, options) do |builder|
            builder.send(input, attribute, *(args << options), &block)
          end
        end
    
        define_method input.to_s + '_label' do |attribute, *args, &block|
          options = args.extract_options!
          text    = args.any? ? args.shift : ''
    
          self.label(attribute, text, options) do |builder|
            builder.send(input, attribute, *(args << options), &block)
          end
        end
    
        define_method input.to_s + '_controls' do |attribute, *args, &block|
          options = args.extract_options!
          text    = args.any? ? args.shift : ''
    
          self.controls(attribute, text, options) do |builder|
            builder.send(input, attribute, *(args << options), &block)
          end
        end    
    end
  end

  protected

  def errors_on?(attribute)
    self.object.errors[attribute].present? if self.object.respond_to?(:errors)
  end

  private

  #
  # Returns an HTML id to uniquely identify the markup around an input field.
  #
  def _wrapper_id(attribute, suffix = nil)
    [
      _object_name + _object_index,
      _attribute_name(attribute),
      suffix,
     ].compact.join('_') if attribute
  end

  #
  # Returns any classes necessary for the wrapper div around fields for
  # +attribute+, such as 'errors' if any errors are present on the attribute.
  # Merges any +classes+ passed in.
  #
  def _wrapper_classes(attribute, *classes)
    classes.push 'error' if attribute and self.errors_on?(attribute)
    classes.compact.join(' ')
  end

  def _attribute_name(attribute)
    attribute.to_s.gsub(/[\?\/\-]$/, '')
  end

  def _object_name
    self.object_name.to_s.gsub(/\]\[|[^-a-zA-Z0-9:.]/, "_").sub(/_$/, "")
  end

  def _object_index
    case
      when options.has_key?(:index) then options[:index]
      when defined?(@auto_index)    then @auto_index
      else                               nil
    end.to_s
  end
end

class TwitterBootstrapFormalwear::FormControls < ActionView::Helpers::FormBuilder
  attr_reader :template
  attr_reader :object
  attr_reader :object_name

  TwitterBootstrapFormalwear::FormBuilder::INPUTS.each do |input|
    define_method input do |attribute, *args, &block|
      options = args.extract_options!
      add_on  = options.delete(:add_on)
      tag     = add_on.present? ? :div : :span
      classes = [ "input", add_on ].compact.join('-')

      template.content_tag(tag, :class => classes) do
        template.concat super attribute, *(args << options)
        template.concat self.error_span(attribute) if self.errors_on?(attribute)
        block.call if block.present?
      end
    end
  end

=begin
  def check_box(attribute, text, options = {}, checked_value = 1, unchecked_value = 0)
    klasses = _merge_classes 'checkbox', options.delete(:inline) && 'inline'

    self.label(attribute, :class => klasses) do
      template.concat super(attribute, options, checked_value, unchecked_value)
      template.concat text
      yield if block_given?
    end
  end

  def radio_button(attribute, value, text = nil, options = {})
    klasses = _merge_classes 'radio', options.delete(:inline) && 'inline'

    self.label(attribute, :class => klasses) do
      template.concat super(attribute, value, options)
      template.concat text || value.to_s.humanize.titleize
      yield if block_given?
    end
  end
=end

  protected

  def error_span(attribute, options = {})
    options[:class] = _merge_classes options[:class], 'help-inline'

    template.content_tag :span,
      self.errors_for(attribute),
      :class => options[:class]
  end

  def errors_for(attribute)
    self.object.errors[attribute].try(:join, ', ')
  end

  def errors_on?(attribute)
    self.object.errors[attribute].present? if self.object.respond_to?(:errors)
  end

  private

  def _merge_classes(string, *classes)
    string.to_s.split(' ').push(*classes.compact).join(' ')
  end
end
