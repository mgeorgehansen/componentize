require 'componentize/fragment'
require 'componentize/builder/mixins/styled_builder'

module Componentize
  class FragmentBuilder
    include StyledBuilder

    def initialize(name, &block)
      @name = name.to_sym
      @style_builders = []

      block.call(self) if block_given?
    end

    def build
      Fragment.new(
        @name,
        @style_builders.map { |b| b.build }
      )
    end
  end
end
