## Copyright M. George Hansen, 2014
# 
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

require 'componentize/serialization/sass_serializable'
require 'componentize/serialization/json_serializable'

module Componentize
  class Style
    include SassSerializable
    include JsonSerializable

    def initialize(name, value)
      @name = name.to_sym
      @value = value.to_str
    end

    attr_reader :name
    attr_reader :value

    def build_sass_tree
      Tree::TreeNode.new("style_#{@name}".to_sym, "#{@name}: #{@value}")
    end

    def build_json_hash
      {
        name: @name,
        value: @value
      }
    end

    def self.from_json_hash(hash)
      self.new(hash.fetch('name'), hash.fetch('value'))
    end
  end
end
