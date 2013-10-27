require 'test_helper'

class HostConfigAllTest < ActiveSupport::TestCase
  setup do
    @config = HostConfig.init! hostname: 'test_all'
  end
  test "that it works..." do
    assert @config.before
    assert @config.after
  end
  test "that it doesn't drop values" do
    assert_equal @config.an_array, ['a', 'b', 'c']
  end
end
