Twitter Bootstrap Formalwear
============================

`twitter_bootstrap_formalwear` dresses up your Ruby on Rails forms with
[Twitter Bootstrap]-friendly markup. It is a lightly-modified fork of
[`twitter_bootstrap_form_for`](https://github.com/stouset/twitter_bootstrap_form_for).

Unlike `twitter_bootstrap_formalwear`, which overwrites existing [Rails FormHelper] methods,
`twitter_bootstrap_formalwear` extends FormHelper with new methods to generate
labels, controls, and control groups.

Because existing methods remain intact, you maintain the option to generate
non-Bootstrap markup in your form if necessary.


## Dependencies ##

Rails and Twitter Bootstrap, of course. Also, a familiarity with [Rails FormHelper]
syntax and usage will be helpful.


## Installation ##

Add the dependency to your `Gemfile`:

    gem 'twitter_bootstrap_formalwear', :git => 'git@github.com:zacwasielewski/twitter_bootstrap_formalwear.git', :branch => 'bootstrap-2.0'

Then run `bundle` from the project directory.


## Usage/Syntax ##


### Initializing a Form: ###

To use `twitter_bootstrap_formalwear`, first create a form using the same syntax as `form_for` or `fields_for`:

    <%= formalwear_form_for (@person, :html => { :class => 'form-horizontal' }) do |f| %>

    <%= formalwear_fields_for (:person, @client do |f| %>


### Generating Form Elements: ###

`twitter_bootstrap_formalwear` extends `form_for` and `fields_for` with additional methods:

- group
- label
- controls
- actions

These methods can be used generically to create container elements:

    <%= f.group do %>
        <!-- HTML goes here! -->
    <% end %>

    # =>
    <div class="control-group">
        <!-- HTML goes here! -->
    </div>

Or, more usefully, they can be prepended with a form element (of any type supported by the [Rails FormHelper]):

    <%= f.text_field_group :first_name, :class => 'input-large' %>

    # =>
    <div class="control-group">
        <label class="control-label" for="first_name">First name</label>
        <div class="controls">
            <input type="text" name="first_name" value="" class="input-large" />
        </div>
    </div>

If you need fine-grained control, you can generate only a Bootstrap label:

    <%= f.text_field_label :first_name %>

    # =>
    <label class="control-label" for="first_name">First name</label>

...or a Bootstrap control:

    <%= f.text_field_control :first_name, :class => 'input-large' %>

    # =>
    <div class="controls">
        <input type="text" name="first_name" value="" class="input-large" />
    </div>

The standard Rails FormHelper methods still work if needed:

    <%= f.text_field :first_name, :class => 'input-large' %>

    # =>
    <input type="text" name="first_name" value="" class="input-large" />


### More Usage Examples ###

Form actions:

    <%= f.actions do %>
       <%= f.submit 'Sign up', :class => 'btn' %>
    <% end %>
    
    # =>
    <div class="form-actions">
        <input class="btn" type="submit" value="Sign up">
    </div>
    
Checkboxes (note that omitting the first argument will omit the label element):

    <%= f.group do %>
        <%= f.check_box :remember_me %> Remember Me?
    <% end %>

    # =>
    <div class="control-group">
        <div class="controls">
            <input id="remember_me" name="remember_me" type="checkbox" value="1" /> Remember Me?
        </div>
    </div>

Add-ons and form help text: may or may not work yet. Documentation coming soon.

## Bugs / Known Issues ##

You may have already noticed that the `label` method exists in `form_for`, even
though I claim above that `twitter_bootstrap_formalwear` doesn't overwrite existing
code. But since the new method dances so lightly (just adding `class="control-label"`),
I think it's safe to simply overwrite the old method. Thoughts?

I've been using this fork successfully on my own projects, but some less common
use cases may be buggy.

[Twitter Bootstrap]: http://twitter.github.com/bootstrap/
[Rails FormHelper]: http://api.rubyonrails.org/classes/ActionView/Helpers/FormHelper.html