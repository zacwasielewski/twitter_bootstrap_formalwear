Twitter Bootstrap Formalwear
============================

`twitter_bootstrap_formalwear` dresses up your Rails FormBuilder forms with
[Twitter Bootstrap]-friendly markup. It is a lightly-modified fork of
[`twitter_bootstrap_form_for`](https://github.com/stouset/twitter_bootstrap_form_for).

Unlike `twitter_bootstrap_formalwear`, which overwrites existing `form_for` methods,
`twitter_bootstrap_formalwear` extends FormBuilder with
new methods to generate labels, controls, and control groups.

Because existing form methods remain intact, you have the option to generate non-Bootstrap
markup in your form if necessary.


## Installation ##

Add the dependency to your `Gemfile`:

    gem 'twitter_bootstrap_formalwear', :git => 'git@github.com:zacwasielewski/twitter_bootstrap_formalwear.git', :branch => 'bootstrap-2.0'

Then run `bundle` from the project directory.


## Usage ##

Begin by creating a form, using the same syntax as `form_for`:

    <%= formalwear_form_for (@user, :url => user_path(@user.id),
                                             :html => { :class => 'form-horizontal' }) do |f| %>

To create form elements, you'll usually want to generate a Bootstrap control-group wrapper, containing a label and controls:

    <%= f.text_field_group :name, :class => 'input-large' %>

    # =>
    <div class="control-group">
        <label class="control-label" for="name">Name</label>
        <div class="controls">
            <input type="text" name="name" value="" class="input-large" />
        </div>
    </div>

To generate only a Bootstrap label:

    <%= f.text_field_label :name %>

    # =>
    <label class="control-label" for="name">Name</label>

...or a Bootstrap control:

    <%= f.text_field_control :name, :class => 'input-large' %>

    # =>
    <div class="controls">
        <input type="text" name="name" value="" class="input-large" />
    </div>

The standard form field helpers are still available if needed:

    <%= f.text_field :name, :class => 'input-large' %>

    # =>
    <input type="text" name="name" value="" class="input-large" />


## More Usage Examples ##

Form actions:

    <%= f.actions do %>
       <%= f.submit 'Sign up', :class => 'btn' %>
    <% end %>
    
    # =>
    <div class="form-actions">
        <input class="btn" type="submit" value="Sign up">
    </div>
    
Checkboxes (note that omitting the first argument will omit the label):

    <%= f.group do %>
        <%= f.check_box :remember_me %> Remember Me?
    <% end %>

    # =>
    <div class="control-group">
        <div class="controls">
            <input id="remember_me" name="remember_me" type="checkbox" value="1" /> Remember Me?
        </div>
    </div>

[Twitter Bootstrap]: http://twitter.github.com/bootstrap/
