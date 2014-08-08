## Copyright M. George Hansen, 2014
# 
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

require 'componentize/builder/mixins/fragmented_builder'
require 'componentize/builder/mixins/styled_builder'
require 'componentize/state/media_state'

module Componentize
  class MediaStateBuilder
    include StyledBuilder
    include FragmentedBuilder

    def initialize(media_query, &block)
      @media_query = media_query
      @style_builders = []
      @fragment_builders = []

      block.call(self) if block_given?
    end

    def build
      MediaState.new(
        @media_query,
        @style_builders.map { |b| b.build },
        @fragment_builders.map { |b| b.build }
      )
    end
  end
end
