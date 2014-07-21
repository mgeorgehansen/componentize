require 'componentize/mixins/fragmented'
require 'componentize/mixins/styled'
require 'componentize/mixins/subcomponent'

module Componentize
  class State
    include Fragmented
    include JsonSerializable
    include SassSerializable
    include Styled
    include Subcomponent

    def initialize(styles = [], fragments = [])
      @styles = styles.to_ary
      @fragments = fragments.to_ary
      @component = nil
    end

    def component=(comp)
      @component = comp
      @fragments.each { |f| f.component = comp }
    end
  end
end
