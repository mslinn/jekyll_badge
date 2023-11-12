require 'jekyll_plugin_support'
require_relative 'jekyll_badge/version'

module JekyllBadge
  # This class implements the jekyll_badge functionality
  # Assumes project is stored on GitHub
  class JekyllBadge < JekyllSupport::JekyllTag
    PLUGIN_NAME = 'jekyll_badge'.freeze
    VERSION = ::JekyllBadge::VERSION

    def render_impl
      @name         = @helper.parameter_specified?('name')  || @page['name']
      @align        = @helper.parameter_specified?('align') || 'right'
      @class        = @helper.parameter_specified?('class') || 'rounded shadow'
      # TODO: put this into _config.yml
      @image        = @helper.parameter_specified?('image') || '/blog/images/git/github-mark'
      @label        = @helper.parameter_specified?('label') || @name
      @style        = @helper.parameter_specified?('style') || ''
      @git_url_base = @helper.parameter_specified?('git_url_base') || 'https://github.com/mslinn'
      @git_url      = @helper.parameter_specified?('git_url') || "#{@git_url_base}/#{@name}"
      generate_output
    end

    private

    def generate_output
      <<~END_CONTENT
        <div class="gem_banner #{@align} #{@class}" style='#{@style}'>
          <div class="one_column" style="text-align: center;">
            <a href='https://rubygems.org/gems/#{@name}' target='_blank' class='imgImgUrl'>
              #{"<code>#{@name}</code>" if @label}
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
