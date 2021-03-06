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

      def mask_all_characters
        lambda { |value| value.to_s.gsub(/./, '*') }
      end

      def mask_email
        lambda { |value| value.to_s.gsub(/(.{1,4}?(?=@)|(?<=@).{1,4})/, '****') }
      end

      def masks
        @all_masks ||= {
          'private_key' => mask_all_characters,
          'password' => mask_all_characters,
          'account_number' => mask_all_characters,
          'token' => mask_all_characters,
          'otp' => mask_all_characters,
          'current_password' => mask_all_characters,
          'new_password' => mask_all_characters,
          'email' => mask_email,
          'user_email' => mask_email,
          'secret_key' => mask_all_characters
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