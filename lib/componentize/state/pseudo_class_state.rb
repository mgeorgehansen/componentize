require 'componentize/state/state'

module Componentize
  class PseudoClassState < State
    def initialize(pseudo_class, styles = [], fragments = [], media_states = [])
      super(styles, fragments)
      @pseudo_class = pseudo_class.to_sym
      @media_states = media_states.to_ary
    end

    attr_reader :pseudo_class

    def component=(comp)
      super(comp)
      @media_states.each { |m| m.component = comp }
    end

    def build_sass_tree
      tree = Tree::TreeNode.new("pseudo_class_state_#{@pseudo_class}".to_sym,
                                "&:#{@pseudo_class}")
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
      hash['pseudo_class'] = @pseudo_class
      hash['styles'] = @styles.map do |s|
        s.build_json_hash
      end unless @styles.empty?
      hash['fragments'] = @fragments.map do |f|
        f.build_json_hash
      end unless @styles.empty?
      hash['media_states'] = @media_states.map do |m|
        m.build_json_hash
      end unless @media_states.empty?
      hash
    end

    def self.from_json_hash(hash)
      self.new(
          hash.fetch('pesudo_class'),
          hash.fetch('styles', []).map do |s|
            j.has_key?('mixin') ? IncludeStyle.from_json_hash(s) :
                Style.from_json_hash(s)
          end,
          hash.fetch('fragments', []).map { |f| Fragment.from_json_hash(f) },
          hash.fetch('media_states', []).map { |m| MediaState.from_json_hash(m) }
      )
    end
  end
end
