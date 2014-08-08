## Copyright M. George Hansen, 2014
# 
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

require 'json'

module Componentize
  module JsonSerializable
    def to_json
      build_json_hash.to_json
    end

    def build_json_hash
      throw 'Unimplemented'
    end

    def self.included(base)
      base.send(:extend, ClassMethods)
    end

    module ClassMethods
      def from_json(string)
        hash = JSON.load(string)
        from_json_hash(hash)
      end

      def from_json_hash(hash)
        throw 'Unimplemented'
      end
    end
  end
end
