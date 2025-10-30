module JekyllBadge
  class JekyllBadge
    private

    # Calling this method can slow down startup time dramatically because of HTTP timeouts
    # Better to use this functionality in parallel, the way it was designed, instead of this way
    def check_url
      @helper.logger.info 'Checking links, please wait ...'
      @link_checker.check @git_url
      @link_checker.results.each_pair do |_bucket, result|
        if result
          output
        else
          msg = "Error: #{@git_url} is broken"
          @helper.logger.error { msg }
          "<span style='color: red;'>#{msg}</span>"
        end
      end
    end

    def debug
      return unless @debug

      debug = "\n<pre>"
      debug += "badge_svg=#{@badge_svg}\n"
      debug += "dist_url=#{@dist_url}\n"
      debug += "git_url_base=#{@git_url_base}\n"
      debug += "git_url=#{@git_url}\n"
      debug += "image=#{@image}"
      debug += "</pre>\n"
      debug
    end

    def default_alt
      case @type
      when 'ruby_gem'
        'Latest Ruby gem'
      when 'golang'
        'GitHub newest release'
      else
        @name
      end
    end

    def default_badge_svg
      case @type
      when 'ruby_gem'
        "https://badge.fury.io/rb/#{@name}.svg"
      when 'golang'
        "https://img.shields.io/github/v/release/#{@user_id}/#{@name}"
      else # This is the only place this check is made
        @warning = "<span style='color: darkred'>Error: Type #{@type} is invalid; choices are golang and ruby_gem</span>"
      end
    end

    def default_dist_url
      case @type
      when 'ruby_gem'
        "https://rubygems.org/gems/#{@name}"
      when 'golang'
        "https://github.com/#{@user_id}/#{@name}/releases"
      end
    end
  end
end
