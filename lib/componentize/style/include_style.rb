## Copyright M. George Hansen, 2014
# 
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

module Componentize
  class IncludeStyle
    def initialize(mixin, *args)
      @mixin = mixin.to_sym
      @kwargs = args.last.is_a?(Hash) ? args.pop : {}
      @args = args.map { |a| a.to_s }
    end

    attr_reader :mixin
    attr_reader :args

    def build_sass_tree
      sass = "+#{@mixin}"
      unless @args.empty? and @kwargs.empty?
        kwargs = @kwargs.map { |k, v| "$#{k.to_s.dasherize}: #{v}" }
        args = @args.concat(kwargs)
        sass << "(#{args.join(', ')})"
      end
      Tree::TreeNode.new("include_#{@mixin}".to_sym, sass)
    end

    def build_json_hash
      {
        mixin: @mixin,
        args: args
      }
    end

    def self.from_json_hash(hash)
      self.new(hash.fetch('mixin'), *hash.fetch('args', []))
    end
  end
end
