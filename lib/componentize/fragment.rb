require 'componentize/style'
require 'componentize/mixins/styled'
require 'componentize/mixins/subcomponent'
require 'componentize/serialization/json_serializable'
require 'componentize/serialization/sass_serializable'

module Componentize
  class Fragment
    include Subcomponent
    include Styled
    include SassSerializable
    include JsonSerializable

    def initialize(name, styles = [])
      @name = name.to_sym
      @styles = styles.to_ary
      @component = nil
    end

    attr_reader :name

    def build_sass_tree
      name = @name.to_s.dasherize
      fragment_tree = Tree::TreeNode.new(
        "fragment_#{name}".to_sym,
        ".#{@component.name.to_s.dasherize}--#{name}"
      )
      @styles.each do |s|
        fragment_tree << s.build_sass_tree
      end
      fragment_tree
    end

    def build_json_hash
      hash = {}
      hash[:name] = @name
      hash[:styles] = @styles.map do |m|
        m.build_json_hash
      end unless @styles.empty?
      hash
    end

    def self.from_json_hash(hash)
      self.new(
        hash.fetch('name'),
        hash.fetch('styles', []).map do |j|
          j.has_key?('mixin') ? IncludeStyle.from_json_hash(j) :
            Style.from_json_hash(j)
        end
      )
    end
  end
end
