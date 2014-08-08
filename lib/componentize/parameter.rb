## Copyright M. George Hansen, 2014
# 
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

require 'componentize/mixins/subcomponent'
require 'componentize/serialization/json_serializable'
require 'componentize/serialization/sass_serializable'
require 'componentize/extensions/string'

require 'tree'

module Componentize
  class Parameter
    include JsonSerializable
    include SassSerializable
    include Subcomponent

    def initialize(name, default)
      @name = name.to_sym
      @default = default
      @component = nil
    end

    def build_sass_tree
      component_name = @component.name.dasherize
      Tree::TreeNode.new("parameter_#{@name}".to_sym,
                         "$#{component_name}__#{@name}: #{@default} !default")
    end

    def build_json_hash
      {
        name: @name,
        default: @default
      }
    end

    def self.from_json_hash(hash)
      self.new(hash.fetch('name'), hash.fetch('default'))
    end
  end
end
