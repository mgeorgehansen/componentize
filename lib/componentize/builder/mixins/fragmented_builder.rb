require 'componentize/builder/fragment_builder'

module Componentize
  module FragmentedBuilder
    def fragment(*args, &block)
      @fragment_builders << FragmentBuilder.new(*args, &block)
    end
  end
end
