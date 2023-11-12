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
  class JekyllBadge < JekyllSupport::JekyllTag
    PLUGIN_NAME = 'jekyll_badge'.freeze
    VERSION = ::JekyllBadge::VERSION

    # def initialize(tag_name, argument_string, parse_context)
    #   super
    #   LinkChecker::Net::HTTP.configure do |config|
    #     config.read_timeout = 5
    #     config.open_timeout = 10
    #   end
    #   @link_checker = LinkChecker::Net::HTTP::Checker.new
    # end

    def render_impl
      @check_links  = @helper.parameter_specified?('check_links')
      @clear        = @helper.parameter_specified?('clear') ? 'clear' : nil
      @name         = @helper.parameter_specified?('name')  || @page['name']
      @align        = @helper.parameter_specified?('align') || 'right'
      @class        = @helper.parameter_specified?('class') || 'rounded shadow'
      # TODO: put this into _config.yml
      @image        = @helper.parameter_specified?('image') || '/blog/images/git/github-mark'
      @label        = @helper.parameter_specified?('label') || @name
      @style        = @helper.parameter_specified?('style') || ''
      @git_url_base = @helper.parameter_specified?('git_url_base') || 'https://github.com/mslinn'
      @git_url      = @helper.parameter_specified?('git_url') || "#{@git_url_base}/#{@name}"

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

    private

    # Calling this method can slow down startup time dramatically because of HTTP timeouts
    def check_url
      puts 'Checking links, please wait ...'
      @link_checker.check @git_url
      @link_checker.results.each_pair do |_bucket, result|
        if result
          generate_output
        else
          msg = "Error: #{@git_url} is broken"
          @helper.logger.error { msg }
          "<span style='color: red;'>#{msg}</span>"
        end
      end
    end

    def generate_output
      classes = "gem_banner #{@align} #{@class} #{@clear}".squish
      <<~END_CONTENT
        <div class="#{classes}" style='#{@style}'>
          <div class="one_column" style="text-align: center;">
            <a href='https://rubygems.org/gems/#{@name}' target='_blank' class='imgImgUrl'>
              #{"<code>#{@label}</code>" unless @label.empty?}
              <div class='imgWrapper imgFlex' style='margin-bottom: 0;'>
                  <picture class='imgPicture'>
                    <source srcset="https://badge.fury.io/rb/#{@name}.svg" type="image/webp">
                    <source srcset="https://badge.fury.io/rb/#{@name}.svg" type="image/png">
                    <img alt='#{@name} version'
                      class="imgImg"
                      src="https://badge.fury.io/rb/#{@name}.svg"
                      style='width: 100%;'
                      title='#{@name} version'
                    />
                  </picture>
                </a>
              </div>
              <div class='imgWrapper imgFlex' style='width: 120px;'>
                <a href='https://github.com/mslinn/#{@name}' target='_blank' class='imgImgUrl'>
                  <picture class='imgPicture'>
                    <source srcset="#{@image}.webp" type="image/webp">
                    <source srcset="#{@image}.png" type="image/png">
                    <img alt='GitHub project for #{@name}'
                      class="imgImg"
                      src="/blog/images/git/github-mark.png"
                      style='width: 100%;'
                      title='Git project for #{@name}'
                    />
                  </picture>
              </div>
            </a>
          </div>
        </div>
      END_CONTENT
    end

    JekyllPluginHelper.register(self, PLUGIN_NAME)
  end
end
