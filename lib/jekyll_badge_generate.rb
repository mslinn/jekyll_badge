module JekyllBadge
  class JekyllBadge
    private

    def generate_banner
      <<~END_CONTENT
        <!-- Colorful badge banner with version info, links to release -->
        #{"<code class='banner_label'>#{@label}</code>" unless @label.empty?}
        <div class='imgWrapper imgFlex center' style='margin-bottom: 0;'>
            <picture class='imgPicture'>
              <source srcset="#{@badge_svg}" type="image/webp">
              <source srcset="#{@badge_svg}" type="image/png">
              <img alt='#{@alt}'
                class="imgImg"
                src="#{@badge_svg}"
                style='width: 100%;'
                title='#{@name}'
              />
            </picture>
          </a>
        </div>
      END_CONTENT
    end

    def generate_remainder
      <<~END_CONTENT
        <!-- Remainder of badge content -->
        <div class='imgWrapper imgFlex center' style='width: 120px;'>
          <a class='imgImgUrl' href="#{@git_url}" target='_blank'>
            <picture class='imgPicture'>
              <source srcset="#{@image}.webp" type="image/webp">
              <source srcset="#{@image}.png"  type="image/png">
              <img alt='GitHub project for #{@name}'
                class="imgImg"
                src="/blog/images/git/github-mark.png"
                style='width: 100%;'
                title='Git project for #{@name}'
              />
            </picture>
        </div>
      END_CONTENT
    end

    def output
      classes = "gem_banner #{@align} #{@class} #{@clear}".squish

      <<~END_CONTENT
        <div class="#{classes}" style='#{@style}'#{@title}>
          <div class="center one_column">
            <a class='imgImgUrl' href='#{@dist_url}' target='_blank'>
              #{generate_banner}
            </a>
            <a class='imgImgUrl' href='#{@git_url}' target='_blank'>
              #{generate_remainder}
            </a>
          </div>#{debug}
        </div>#{@warning}
      END_CONTENT
    end
  end
end
