# frozen_string_literal: true

module Chihiro
  class MaskUtil
    class << self
      def mask(hash)
        return hash unless hash.is_a? Hash
        
        hash.each do |key, value|
          if value.is_a? Hash
            hash[key] = mask(value)
          else
            hash[key] = mask_item(key, value)
          end
        end
      end

      private

      def masks
        {
          'password' => ->(value) { value.to_s.gsub(/./, '*') }
        }
      end

      def mask_item(key, origin_str)
        mask_proc = masks[key.to_s]
        return origin_str unless mask_proc
        mask_proc.call(origin_str)
      end
    end
  end
end