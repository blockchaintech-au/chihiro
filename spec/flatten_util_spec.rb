# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Chihiro::FlattenUtil do
  it 'should flat a nested hash' do
    msg = {
      password: '***',
      message: 'abc',
      aaa: {
        password: '***',
        other: 'otherMsg'
      }
    }

    result = Chihiro::FlattenUtil.flat(msg)
    
    expect(result).to eq({ password: '***',
                           message: 'abc',
                           aaa: "{:password=>\"***\", :other=>\"otherMsg\"}" })
  end
end