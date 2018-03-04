# Octoprint API Client
[![Build Status](https://travis-ci.org/tobiasfeistmantl/octoprint-api-ruby.svg?branch=master)](https://travis-ci.org/tobiasfeistmantl/octoprint-api-ruby)

This client library makes it easy to use the Octoprint API in Ruby.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'octoprint_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install octoprint_api

## Usage

```ruby
require 'octoprint'

octoprint = Octoprint.new('https://my-awesome-octoprint-server.com', 'MY_S3CURE_AP1_KEY')

octoprint.api.version  # => {"api"=>"YOUR API VERSION", "server"=>"YOUR SERVER VERSION"}
```

### Wanna now more about the API?
[API Reference of Octoprint](http://docs.octoprint.org/en/master/api/index.html)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tobiasfeistmantl/octoprint-api-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the OctoprintApi project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/tobiasfeistmantl/octoprint-api-ruby/blob/master/CODE_OF_CONDUCT.md).
