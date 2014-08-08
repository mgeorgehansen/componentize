## Copyright M. George Hansen, 2014
# 
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

require 'tree'

module Componentize
  module SassSerializable
    def to_sass
      build_sass_tree.map do |n|
        if n.name === :root
          ''
        else
          ('  ' * (n.node_depth - 1)) + n.content
        end
      end.join("\n")
    end

    def build_sass_tree
      throw 'Unimplemented'
    end
  end
end
