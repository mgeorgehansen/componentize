require 'componentize/builder/media_state_builder'

module Componentize
  module MediaStatefulBuilder
    def media_state(*args, &block)
      @media_state_builders << MediaStateBuilder.new(*args, &block)
    end
  end
end
