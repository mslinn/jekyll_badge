# `Badge` [![Gem Version](https://jekyll_badge.fury.io/rb/jekyll_badge.svg)](https://jekyll_badge.fury.io/rb/jekyll_badge)

Displays a badge on a Jekyll page for the package showing its version.


## Installation

Add the following to your Jekyll website's `Gemfile`:

```ruby
group :jekyll_plugins do
  gem 'jekyll_badge'
end
```

And then execute:

```shell
$ bundle
```

### Image

Copy the contents of `demo/blog/images/git/` to a similarly named directory on your website.


## Usage

See [demo/index.html](demo/index.html) for examples.


### Options

- `align` &ndash; Float badge `left`, `center` or `right`.
- `class` &ndash; Override default class for generated badge (`rounded shadow`).
- `clear` &ndash; Ensure the badge is moved below (cleared) below floating elements that precede it.
- `git_url_base` &ndash; Override the default value (`https://github.com/mslinn`)
- `image` &ndash; Override the default value (`/blog/images/git/github-mark`)
- `name` &ndash; Override the default value (name of page)
- `label` &ndash; Override the default value (name value above)
- `style` &ndash; CSS style
- `git_url` &ndash; Override the default value(`git_url_base/name`)


## Development

After checking out this git repository, install dependencies by typing:

```shell
$ bin/setup
```

You should do the above before running Visual Studio Code.


### Run the Tests

```shell
$ bundle exec rake test
```


### Interactive Session

The following will allow you to experiment:

```shell
$ bin/console
```


### Local Installation

To install this gem onto your local machine, type:

```shell
$ bundle exec rake install
```


### To Release A New Version

To create a git tag for the new version, push git commits and tags,
and push the new version of the gem to https://rubygems.org, type:

```shell
$ bundle exec rake release
```


## Contributing

Bug reports and pull requests are welcome at https://github.com/mslinn/jekyll_badge.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
