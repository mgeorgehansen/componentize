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
