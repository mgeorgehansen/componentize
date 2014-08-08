## Copyright M. George Hansen, 2014
# 
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

require 'componentize/style/include_style'

module Componentize
  class IncludeStyleBuilder
    def initialize(mixin, *args)
      @mixin = mixin.to_str
      @args = args
    end

    def build
      IncludeStyle.new(@mixin, *@args)
    end
  end
end
