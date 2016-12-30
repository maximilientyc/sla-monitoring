require 'test_helper'

class TargetTest < ActiveSupport::TestCase
  test 'should not be valid when life_url empty' do
    # given
    target = Target.new timeout: 5

    # when
    target.valid?

    # then
    assert_equal ["can't be blank"], target.errors.messages[:life_url]
  end

  test 'should not be valid when timeout empty' do
    # given
    target = Target.new life_url: 'http://www.google.fr/'

    # when
    target.valid?

    # then
    assert_equal ["can't be blank"], target.errors.messages[:timeout]
  end
end
