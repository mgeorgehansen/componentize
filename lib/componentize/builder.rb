## Copyright M. George Hansen, 2014
# 
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

require 'componentize/builder/component_builder'

module Componentize
  def self.component(*args, &block)
    ComponentBuilder.new(*args, &block).build
  end
end
