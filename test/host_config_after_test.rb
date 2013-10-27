require 'test_helper'

class HostConfigAfterTest < ActiveSupport::TestCase
  setup do
    @config = HostConfig.init! hostname: 'test_after'
  end
  test "that it works..." do
    assert @config.after
  end
  test "that it doesn't drop values" do
    assert_equal @config.x, 'x'
  end
  test "that the included file cannot be overriden" do
    assert_equal @config.override_me, 1
  end
end
