## Copyright M. George Hansen, 2014
# 
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

require 'componentize/style/style'

module Componentize
  class StyleBuilder
    def initialize(name, value)
      @name = name.to_sym
      @value = value.to_str
    end

    def build
      Style.new(@name, @value)
    end
  end
end
