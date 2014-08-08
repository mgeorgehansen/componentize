## Copyright M. George Hansen, 2014
# 
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

require 'componentize/builder/mixins/fragmented_builder'
require 'componentize/builder/mixins/media_stateful_builder'
require 'componentize/builder/mixins/styled_builder'
require 'componentize/state/pseudo_class_state'

module Componentize
  class PseudoClassStateBuilder
    include FragmentedBuilder
    include MediaStatefulBuilder
    include StyledBuilder

    def initialize(pseudo_class, &block)
      @pseudo_class = pseudo_class.to_sym
      @style_builders = []
      @fragment_builders = []
      @media_state_builders = []

      block.call(self) if block_given?
    end

    def build
      PseudoClassState.new(
        @pseudo_class,
        @style_builders.map { |b| b.build },
        @fragment_builders.map { |b| b.build },
        @media_state_builders.map { |b| b.build }
      )
    end
  end
end
