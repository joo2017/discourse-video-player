# name: discourse-video-player
# about: Adds support for m3u8 video files using Video.js player
# version: 0.1
# authors: Your Name
# url: https://github.com/yourusername/discourse-video-player

enabled_site_setting :video_player_enabled

register_asset "stylesheets/video-js.css"
register_asset "javascripts/discourse/initializers/init-video-player.js.es6"

after_initialize do
  require_dependency "onebox"

  module ::Onebox
    class Engine
      class VideoOnebox
        include Engine

        matches_regexp(%r{^(https?:)?//.*\.(mov|mp4|webm|ogv|m3u8)(\?.*)?$}i)

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
