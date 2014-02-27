require 'test_helper'

class HostConfigTest < ActiveSupport::TestCase
  test "sanity" do
    assert_kind_of Module, HostConfig
  end

  test "generates a configuration" do
    @config = HostConfig.init! hostname: 'test'
    assert_kind_of OpenStruct, @config
    assert_equal @config.some_value, 1
  end

  test "doesn't rely on Rails" do
    require 'logger'
    assert_nothing_raised do
      @config = HostConfig.init! hostname: 'test',
                                 logger: Logger.new($sterr),
                                 base_path: File.join(Dir.pwd, 'test', 'dummy')
    end
  end

  test "can be assigned to a constant" do
    AppConfig = HostConfig.init! hostname: 'test'
    assert_kind_of OpenStruct, AppConfig
  end

  test "more values can be assigned" do
    @config = HostConfig.init! hostname: 'test'
    @config.something_else = { ok: true }
    assert @config.something_else[:ok]
  end

  test "raises when config file not found" do
    assert_raises( HostConfig::MissingConfigFile ) do
      @config = HostConfig.init! hostname: SecureRandom.hex(16)
    end
  end

  test "attempts to find the hostname by itself" do
    require 'socket'
    hostname = Socket.gethostname.split('.').first
    begin
      HostConfig.init!
    rescue => e
      assert_match "#{hostname}.yml", e.message
    end
  end

  test "passing nil as hostname falls back to discovery" do
    require 'socket'
    hostname = Socket.gethostname.split('.').first
    begin
      HostConfig.init! hostname: nil
    rescue => e
      assert_match "#{hostname}.yml", e.message
    end
  end
end
