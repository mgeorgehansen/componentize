## Copyright M. George Hansen, 2014
# 
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

require 'componentize/builder/class_state_builder'
require 'componentize/builder/pseudo_class_state_builder'

module Componentize
  module StatefulBuilder
    def class_state(*args, &block)
      @state_builders << ClassStateBuilder.new(*args, &block)
    end

    def pseudo_class_state(*args, &block)
      @state_builders << PseudoClassStateBuilder.new(*args, &block)
    end
  end
end
