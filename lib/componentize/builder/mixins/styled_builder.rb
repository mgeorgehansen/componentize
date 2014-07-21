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
