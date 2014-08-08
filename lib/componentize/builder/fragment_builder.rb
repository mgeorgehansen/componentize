## Copyright M. George Hansen, 2014
# 
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

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
