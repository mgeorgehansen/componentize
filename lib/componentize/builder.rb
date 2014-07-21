require 'componentize/builder/component_builder'

module Componentize
  def self.component(*args, &block)
    ComponentBuilder.new(*args, &block).build
  end
end
