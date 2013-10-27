require 'test_helper'

class HostConfigBeforeTest < ActiveSupport::TestCase
  setup do
    @config = HostConfig.init! hostname: 'test_before'
  end
  test "that it works..." do
    assert @config.before
  end
  test "that it doesn't drop values" do
    assert_equal @config.y, 'y'
  end
  test "that the included file can be overridden" do
    assert_equal @config.override_me, 3
  end
end
