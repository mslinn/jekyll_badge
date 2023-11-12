require 'jekyll_plugin_support'
require_relative 'jekyll_badge/version.rb'

# This Jekyll tag plugin is a minimal example.
#
# See https://www.mslinn.com/jekyll/10200-jekyll-plugin-background.html
# See https://www.mslinn.com/jekyll/10400-jekyll-plugin-template-collection.html
#
# @example Heading for this example
#   {% jekyll_badge param1='value1' %}
#
# The Jekyll log level defaults to :info, which means all the Jekyll.logger statements below will not generate output.
# You can control the log level when you start Jekyll.
# To set the log level to :debug, write an entry into _config.yml, like this:
# plugin_loggers:
#   JekyllBadge: debug
module JekyllBadge
  # This class implements the Jekyll jekyll_badge functionality
  class JekyllBadge < JekyllSupport::JekyllTag
    PLUGIN_NAME = 'jekyll_badge'.freeze
    VERSION = Badge::VERSION

    # Put your plugin logic here.
    # The following variables are predefined:
    #   @argument_string, @config, @envs, @helper, @layout, @logger, @mode, @page, @paginator, @site, @tag_name and @theme
    #
    # @param tag_name [String] is the name of the tag, which we already know.
    # @param argument_string [String] the arguments from the web page.
    # @param tokens [Liquid::ParseContext] tokenized command line
    # @return [void]
    def render_impl
      @align = @helper.parameter_specified? 'align' # Obtain the value of parameter align
      @class = @helper.parameter_specified? 'class' # Obtain the value of parameter class
      @label = @helper.parameter_specified? 'label' # Obtain the value of parameter label
      @style = @helper.parameter_specified? 'style' # Obtain the value of parameter style
      <<~END_OUTPUT
        <pre class="example">
          @align='#{@align}'
          @class='#{@class}'
          @label='#{@label}'
          @style='#{@style}'
          Remaining markup: '#{@helper.remaining_markup}'.
        </pre>
      END_OUTPUT
    end

    JekyllPluginHelper.register(self, PLUGIN_NAME)
  end
end
