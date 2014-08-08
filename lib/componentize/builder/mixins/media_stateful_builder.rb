## Copyright M. George Hansen, 2014
# 
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

require 'componentize/builder/media_state_builder'

module Componentize
  module MediaStatefulBuilder
    def media_state(*args, &block)
      @media_state_builders << MediaStateBuilder.new(*args, &block)
    end
  end
end
