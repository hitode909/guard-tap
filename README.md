# Guard::Tap [![Build Status](https://travis-ci.org/hitode909/guard-tap.png?branch=master)](https://travis-ci.org/hitode909/guard-tap)

RSpec guard allows to automatically run TAP based test suites and print a report.

## Installation

The simplest way to install Guard is to use [Bundler](http://gembundler.com/).
Please make sure to have [Guard](https://github.com/guard/guard) installed.

Add Guard::Tap to your `Gemfile`:

```ruby
group :development do
  gem 'guard-tap'
end
```
Add the default Guard::Tap template to your `Guardfile` by running:

```bash
$ guard init tap
```

## Usage

Please read [Guard usage doc](https://github.com/guard/guard#readme).

## Guardfile

RSpec guard can be adapted to all kinds of projects.

### Standard Perl project



``` ruby
guard :tap, command: 'perl' do
  watch %r{^t/.*\.t$}
end
```
### Detect the test files

You can watch `lib/` and detect the test file for the changed class.

```ruby
guard :tap, command: 'perl' do
  watch %r{^t/.*\.t$}
  watch %r{^(lib/.*\.pm)$} do |m|
    modified_file = m[0]

    all_test_files = Dir.glob('t/**/**.t')

    all_test_files.sort_by{ |test_file|
      # sort by similarity of path
      a = test_file
      b = modified_file
      delimiter = %r{[/_\-\.]}
      a_fragments = a.split(delimiter)
      b_fragments = b.split(delimiter)
      (a_fragments + b_fragments).uniq.length.to_f / (a_fragments + b_fragments).length.to_f
    }.first
  end
end
```

## Options

You can pass the command to execute test file using the `:command` option:
By default, Guard::Tap just execute the file.

If you are using carton, set `carton exec -- perl` to command.

``` ruby
guard :tap, command: 'carton exec -- perl' do
  watch %r{^t/.*\.t$}
end
```

## Notification

Guard::Tap parses TAP output and notifify error messages when the tests are failed.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## See also

- [Test Anything Protocol](http://testanything.org/)