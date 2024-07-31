after_initialize do
  require_dependency "onebox"

  module ::Onebox
    module Engine
      class VideoOnebox
        def to_html
          if @url.match(%r{\.m3u8$})
            <<-HTML
              <div class="onebox video-onebox">
                <video class="video-js" controls preload="auto" width="100%" data-setup='{"fluid": true}'>
                  <source src="#{@url}" type="application/x-mpegURL">
                </video>
              </div>
            HTML
          else
            super
          end
        end
      end
    end
  end
end
