require 'componentize/component'
require 'componentize/builder/mixins/fragmented_builder'
require 'componentize/builder/mixins/media_stateful_builder'
require 'componentize/builder/mixins/stateful_builder'
require 'componentize/builder/mixins/styled_builder'

module Componentize
  class ComponentBuilder
    include FragmentedBuilder
    include MediaStatefulBuilder
    include StatefulBuilder
    include StyledBuilder

    def initialize(name, ancestor = :none, &block)
      @name = name.to_sym
      @ancestor = ancestor.to_sym
      @style_builders = []
      @fragment_builders = []
      @media_state_builders = []
      @state_builders = []

      block.call(self) if block_given?
    end

    def build
      Component.new(
        @name,
        @ancestor,
        @style_builders.map { |b| b.build },
        @fragment_builders.map { |b| b.build },
        @media_state_builders.map { |b| b.build },
        @state_builders.map { |b| b.build }
      )
    end
  end
end
