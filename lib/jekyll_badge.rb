require 'jekyll_plugin_support'
require 'net/http'
require 'ruby-link-checker'
require 'uri'

require_relative 'jekyll_badge/version'

class String
  def squish
    strip.gsub(/\s+/, ' ')
  end
end

module JekyllBadge
  # This class implements the jekyll_badge functionality
  # Assumes project is stored on GitHub
  class JekyllBadge < ::JekyllSupport::JekyllTag
    PLUGIN_NAME = 'jekyll_badge'.freeze
    VERSION = ::JekyllBadge::VERSION

    def render_impl
      # Keyword options
      @clear        = @helper.parameter_specified?('clear') ? 'clear' : nil
      @debug        = @helper.parameter_specified?('debug')

      # Primary options
      @align        = @helper.parameter_specified?('align') || 'right'
      @class        = @helper.parameter_specified?('class') || 'rounded shadow'
      # TODO: put this into _config.yml
      @git_url_base = @helper.parameter_specified?('git_url_base') || 'https://github.com/mslinn'
      @image        = @helper.parameter_specified?('image')        || '/blog/images/git/github-mark'
      @style        = @helper.parameter_specified?('style')        || ''
      @type         = @helper.parameter_specified?('type')         || 'ruby_gem'
      @user_id      = @helper.parameter_specified?('user_id')      || 'mslinn'

      # Derived options
      @name         = @helper.parameter_specified?('name')  || @page['name']
      @label        = @helper.parameter_specified?('label') || @name
      @style        = "#{@style} width: 28em;".squish if @debug

      # Further derived options
      @alt          = @helper.parameter_specified?('alt')       || default_alt
      @badge_svg    = @helper.parameter_specified?('badge_src') || default_badge_svg
      @dist_url     = @helper.parameter_specified?('dist_url')  || default_dist_url
      @git_url      = @helper.parameter_specified?('git_url')   || "#{@git_url_base}/#{@name}"

      # Yet further derived options
      @title        = " title='#{@alt}'" if @alt

      # Tweaking
      @label = @label.gsub('_', '_<wbr>')
      unless %w[left center right].include? @align
        @helper.logger.warn { "Ignoring invalid align value ('#{@align}') on line #{@line_number} (plus front matter) of #{@page['name']}." }
        @align = 'right'
      end

      if @check_links
        check_url
      else
        generate_output
      end
    end

    ::JekyllSupport::JekyllPluginHelper.register(self, PLUGIN_NAME)
  end
end

require_relative 'jekyll_badge_private'
require_relative 'jekyll_badge_generate'
