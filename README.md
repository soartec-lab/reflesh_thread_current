# RefreshThreadCurrent

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/refresh_thread_current`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'refresh_thread_current'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install refresh_thread_current

## Usage

This gem provides a rack middleware RefreshThreadCurrent::Middlewarewhich set all thread local vriable and fiber local variable be nil in each rack request, which results in refreshing all thread local variables in each rack request.

NOTE: refresh_thread_current work on unicorn server. does not work with puma, and webrick server in rails 5 and 6.

```config/application.rb:ruby
class Application < Rails::Application
  config.middleware.insert_before ActionDispatch::Executor,
    RefreshThreadCurrent::Middleware
end
```

Middleware check.

```
$ bundle exec rake middleware
```

Use unicorn server to run your application.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/refresh_thread_current. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RefreshThreadCurrent project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/refresh_thread_current/blob/master/CODE_OF_CONDUCT.md).
