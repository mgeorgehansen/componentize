## Copyright M. George Hansen, 2014
# 
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

require 'componentize/fragment'
require 'componentize/style'
require 'componentize/state/state'
require 'componentize/state/media_state'
require 'componentize/serialization/json_serializable'
require 'componentize/serialization/sass_serializable'

module Componentize
  class ClassState < State
    def initialize(class_name, styles = [], fragments = [], media_states = [])
      super(styles, fragments)
      @class_name = class_name.to_sym
      @media_states = media_states.to_ary
    end

    attr_reader :class_name

    def component=(comp)
      super(comp)
      @media_states.each { |m| m.component = comp }
    end

    def build_sass_tree
      name = @class_name.to_s.dasherize
      tree = Tree::TreeNode.new("state_#{name}".to_sym, "&.#{name}")
      @styles.each do |s|
        tree << s.build_sass_tree
      end
      @fragments.each do |f|
        tree << f.build_sass_tree
      end
      @media_states.each do |m|
        tree << m.build_sass_tree
      end
      tree
    end

    def build_json_hash
      hash = {}
      hash['class_name'] = @class_name
      hash['styles'] = @styles.map do |s|
        s.build_json_hash
      end unless @styles.empty?
      hash['fragments'] = @fragments.map do |f|
        f.build_json_hash
      end unless @fragments.empty?
      hash['media_states'] = @media_states.map do |m|
        m.build_json_hash
      end unless @media_states.empty?
      hash
    end

    def self.from_json_hash(hash)
      self.new(
        hash.fetch('class_name'),
        hash.fetch('styles', []).map do |j|
          j.has_key?('mixin') ? IncludeStyle.from_json_hash(j) :
            Style.from_json_hash(j)
        end,
        hash.fetch('fragments', []).map { |j| Fragment.from_json_hash(j) },
        hash.fetch('media_states', []).map { |j| MediaState.from_json_hash(j) }
      )
    end
  end
end
