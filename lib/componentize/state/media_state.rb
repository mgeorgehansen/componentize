## Copyright M. George Hansen, 2014
# 
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

require 'componentize/fragment'
require 'componentize/style'
require 'componentize/state/state'
require 'componentize/serialization/json_serializable'
require 'componentize/serialization/sass_serializable'

module Componentize
  class MediaState < State
    include SassSerializable
    include JsonSerializable

    def initialize(media_query, styles = [], fragments = [])
      super(styles, fragments)
      @media_query = media_query.to_str
    end

    attr_reader :media_query

    def build_sass_tree
      tree = Tree::TreeNode.new("media_state_#{@media_query}".to_sym,
                                "@media #{@media_query}")
      @styles.each do |s|
        tree << s.build_sass_tree
      end
      @fragments.each do |f|
        tree << f.build_sass_tree
      end
      tree
    end

    def build_json_hash
      hash = {}
      hash['media_query'] = @media_query
      hash['styles'] = @styles.map do |s|
        s.build_json_hash
      end unless @styles.empty?
      hash['fragments'] = @fragments.map do |f|
        f.build_json_hash
      end unless @styles.empty?
      hash
    end

    def self.from_json_hash(hash)
      self.new(
        hash.fetch('media_query'),
        hash.fetch('styles', []).map do |j|
          j.has_key?('mixin') ? IncludeStyle.from_json_hash(j) :
            Style.from_json_hash(j)
        end,
        hash.fetch('fragments', []).map { |j| Fragment.from_json_hash(j) }
      )
    end
  end
end
