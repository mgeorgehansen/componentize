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
