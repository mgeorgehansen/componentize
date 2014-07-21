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
