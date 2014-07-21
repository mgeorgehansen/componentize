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
