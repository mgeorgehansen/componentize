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
