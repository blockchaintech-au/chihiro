# frozen_string_literal: true

RSpec.describe Chihiro::MaskUtil do
  describe 'mask password' do
    it 'should mask password' do
      msg = {
        password: 'abcde',
        message: 'message1'
      }
      masked = Chihiro::MaskUtil.mask(msg)
      expect(masked).to eq({ password: '*****', message: 'message1' })
    end

    it 'should mask nested password' do
      msg = {
        password: 'abcde',
        message: 'message1',
        aaa: {
          password: '12345',
          other: 'otherMsg'
        }
      }
      masked = Chihiro::MaskUtil.mask(msg)
      expect(masked).to eq({ password: '*****',
                             message: 'message1',
                             aaa: { password: '*****', other: 'otherMsg' } })
    end
  end

  describe 'mask account number' do
    it 'should mask password' do
      msg = {
        account_number: '12345678',
        message: 'message1'
      }
      masked = Chihiro::MaskUtil.mask(msg)
      expect(masked).to eq({ account_number: '********', message: 'message1' })
    end
  end
end