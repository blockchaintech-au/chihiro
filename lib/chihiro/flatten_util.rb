# frozen_string_literal: true

module Chihiro
  class FlattenUtil
    class << self
      def flat(hash)
        return hash unless hash.is_a? Hash
        hash.map { |k, v| [k, v.to_s] }.to_h
      end
    end
  end
end