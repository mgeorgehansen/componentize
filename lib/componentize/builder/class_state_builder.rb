require 'componentize/builder/mixins/fragmented_builder'
require 'componentize/builder/mixins/media_stateful_builder'
require 'componentize/builder/mixins/styled_builder'
require 'componentize/state/class_state'

module Componentize
  class ClassStateBuilder
    include FragmentedBuilder
    include MediaStatefulBuilder
    include StyledBuilder

    def initialize(class_name, &block)
      @class_name = class_name.to_sym
      @style_builders = []
      @fragment_builders = []
      @media_state_builders = []

      block.call(self) if block_given?
    end

    def build
      ClassState.new(
        @class_name,
        @style_builders.map { |b| b.build },
        @fragment_builders.map { |b| b.build },
        @media_state_builders.map { |b| b.build }
      )
    end
  end
end
