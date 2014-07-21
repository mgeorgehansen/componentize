# Componentize

A Ruby library providing a model for defining reusable SASS components and the
mechanisms for outputting the resulting SASS code as well as serializing
components to JSON for further processing.

The design of SASS components are heavily influenced by SMACSS but refined to
leverage the syntax and scripting power of SASS. Each SASS component is
implemented as a class with nested styles, fragments and states. E.g.:

    // Class containing the component definition.
    .navigation
      // Styles for the default state.
      color: white
      +background(#444)

      //
      .navigation--item

By nesting the rules underneath a class and namespacing fragment names we
reduce global namespace pollution to an absolute minimum and ensure that styles
don't accidentally get applied to the component's fragments. There is also
no ambiguity as to whether fragement selectors like ".navigation--item"
apply to other classes outside of the navigation component.

## Installation

Add this line to your application's Gemfile:

    gem 'componentize'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install componentize

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it ( http://github.com/technopolitica/componentize/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
