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

#### Keyword Options

- `clear`    &ndash; Ensures the badge is rendered below preceding floating elements.


#### Primary Options

Override these name/value options as required.

- `align`    &ndash; Align badge `left`, `center` or `right`, defaults to `right`.
- `alt`      &ndash; Alt text for badge image, also used as title for badge.
  Defaults to `name`.
- `class`    &ndash; Override classes for generated badge,
  defaults to `rounded shadow`.
- `dist_url` &ndash; Badge banner link target,
  defaults to `https://rubygems.org/gems/name`.
- `image`    &ndash; Git repository image, without the filetype,
  defaults to `/blog/images/git/github-mark`.
- `name`     &ndash; name of component, defaults to the name of the enclosing page.
- `label`    &ndash; displayed name of the badge, defaults to `name`.
- `style`    &ndash; Additional CSS style for the badge container.
- `title`    &ndash; Displayed text when the user hovers their mouse over the
  badge. Defaults to the `alt` value.

#### Derived Options

Derived options can be overridden, just like primary options.

- `badge_svg`    &ndash; URL for badge image,
  defaults to `https://badge.fury.io/rb/name.svg`.
- `git_url_base` &ndash; GitHub User URL,
  defaults to `https://github.com/mslinn`.
- `git_url`      &ndash; Repository URL, defaults to `git_url_base/name`.


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
