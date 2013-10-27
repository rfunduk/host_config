# HostConfig

Simple per-host configuration for Rails 4.


## Setup/Usage

First add it to your `Gemfile`:

    gem 'host_config'

Then make an initializer (or add it to one you already have, like so):

    AppConfig = HostConfig.init!

That's really it. This will attempt to load `config/hosts/HOSTNAME.yml`
and assign an OpenStruct to `AppConfig` which you can then use all over
your app. You can also override the hostname:

    override_hostname = Rails.env.production? ? 'aws' :
                        Rails.env.staging? ? 'staging' :
                        nil
    AppConfig = HostConfig.init! hostname: override_hostname

...or something similar, so that you can share config for production environments.
This is a good alternative to environment variables. You can handle your configuration
just like you already handle `database.yml` (eg, by not committing production config
to the git repo, but adding it to each host out of band).

You can also add more values to it for things that aren't host-specific:

    AppConfig.analytics_id = 'UA-XXXXXXXX-Y'
    AppConfig.sanitize = Sanitize::Config::RELAXED
    AppConfig.sanitize[:attributes]['a'] = %w{ target href name }
    AppConfig.sanitize[:add_attributes] = {
      'a' => { 'target' => '_blank' }
    }

...can be quite convenient.


## Configuration

Configuration is in YAML files.

    ---
      force_ssl: true
      protocol: https
      application_host: myapp.com

      twitter:
        consumer: ABC
        secret: XYZ

      vegetables:
        - broccoli
        - carrots
        - corn

As simple as that. You can also setup common stuff in files prefixed with `_`. Eg,
`_defaults.yml`, and load either before or after the stuff in the primary config:

    ---
      load_before:
        - defaults
      other_stuff: 'here'

This will look for `_defaults.yml` and deep-merge in the rest. You can also use
`load_after`, which will of course override values in the primary config... why would
you ever need this? I don't know :)

See the `test/dummy` app and the tests for the details if it isn't clear.
