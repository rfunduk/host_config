require 'ostruct'
require 'socket'

module HostConfig
  VERSION = "0.0.1"

  class MissingConfigFile < StandardError; end

  class << self
    def init!( opts={} )
      @logger = opts[:logger] || Rails.logger
      @hostname = opts[:hostname] || Socket.gethostname.split('.').shift
      @config = {}
      @config[:hostname] = opts[:hostname]
      @logger.debug "Loading host config #{@hostname}"
      process( load_config( @hostname ) )
    end

    private

    def load_config( file )
      begin
        path = "#{Rails.root}/config/hosts/#{file}.yml"
        data = File.read(path)
        YAML.load( data )
      rescue Errno::ENOENT
        raise MissingConfigFile.new( "Missing config file '#{path}', could not setup HostConfig!" )
      end
    end

    def process( config )
      load_before = config.delete('load_before')
      load_after = config.delete('load_after')

      if load_before.is_a? Array
        load_before.each do |file|
          @logger.debug "   including... _#{file}"
          c = load_config( "_#{file}" )
          process( c )
        end
      end

      @config.deep_merge! config

      if load_after.is_a? Array
        load_after.each do |file|
          c = load_config( "_#{file}" )
          process( c )
        end
      end

      to_openstruct(@config)
    end

    def to_openstruct( obj )
      case obj
      when Array
        obj.map { |el| to_openstruct(el) }
      when Hash
        ::OpenStruct.new( obj.each_with_object({}) do |(k,v), h|
                            h[k] = to_openstruct(v)
                          end )
      else
        obj
      end
    end
  end
end
