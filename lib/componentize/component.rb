## Copyright M. George Hansen, 2014
# 
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

require 'componentize/fragment'
require 'componentize/style'
require 'componentize/state'
require 'componentize/extensions/string'
require 'componentize/mixins/fragmented'
require 'componentize/mixins/styled'
require 'componentize/serialization/json_serializable'
require 'componentize/serialization/sass_serializable'

require 'tree'

module Componentize
  class Component
    include Styled
    include Fragmented
    include SassSerializable
    include JsonSerializable

    def initialize(name, ancestor = :none, styles = [], fragments = [],
                   media_states = [], states = [])
      @name = name.to_sym
      @ancestor = ancestor.to_sym
      @styles = styles.to_ary
      @fragments = fragments.to_ary
      @fragments.each { |f| f.component = self }
      @media_states = media_states.to_ary
      @media_states.each { |m| m.component = self }
      @states = states.to_ary
      @states.each { |c| c.component = self }
    end

    attr_reader :name
    attr_reader :ancestor

    def media_states
      @media_states.clone
    end

    def states
      @states.clone
    end

    def build_sass_tree
      name = @name.to_s.dasherize
      tree = Tree::TreeNode.new(:root)
      tree << Tree::TreeNode.new(:component, "%#{name}")
      tree[:component] << Tree::TreeNode.new(
        :extend,
        "@extend %#{@ancestor.to_s.dasherize}"
      ) unless @ancestor === :none
      @styles.each do |s|
        tree[:component] << s.build_sass_tree
      end
      @fragments.each do |f|
        tree[:component] << f.build_sass_tree
      end
      @media_states.each do |m|
        tree[:component] << m.build_sass_tree
      end
      @states.each do |s|
        tree[:component] << s.build_sass_tree
      end
      tree
    end

    def build_json_hash
      hash = {}
      hash[:name] = @name
      hash[:ancestor] = @ancestor unless @ancestor === :none
      hash[:styles] = @styles.map do |s|
        s.build_json_hash
      end unless @styles.empty?
      hash[:fragments] = @fragments.map do |f|
        f.build_json_hash
      end unless @fragments.empty?
      hash[:media_states] = @media_states.map do |m|
        m.build_json_hash
      end unless @media_states.empty?
      hash[:states] = @states.map do |s|
        s.build_json_hash
      end unless @states.empty?
      hash
    end

    def self.from_json_hash(hash)
      self.new(
        hash.fetch('name'),
        hash.fetch('ancestor', :none),
        hash.fetch('styles', []).map do |j|
          j.has_key?('mixin') ? IncludeStyle.from_json_hash(j) :
            Style.from_json_hash(j)
        end,
        hash.fetch('fragments', []).map { |j| Fragment.from_json_hash(j) },
        hash.fetch('media_states', []).map { |j| MediaState.from_json_hash(j) },
        hash.fetch('states', []).map do |j|
            case j.fetch('type', :class_state).to_sym
              when :class_state
                ClassState.from_json_hash(j)
              when :pseudo_class_state
                PseudoClassState.from_json_hash(j)
            end
        end
      )
    end
  end
end
