## Copyright M. George Hansen, 2014
# 
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

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
