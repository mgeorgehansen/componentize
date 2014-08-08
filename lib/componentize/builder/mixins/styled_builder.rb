## Copyright M. George Hansen, 2014
# 
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

require 'componentize/builder/style_builder'
require 'componentize/builder/include_style_builder'

module Componentize
  module StyledBuilder
    def style(*args)
      @style_builders << StyleBuilder.new(*args)
    end

    def include(mixin, *args)
      @style_builders << IncludeStyleBuilder.new(mixin, *args)
    end
  end
end
