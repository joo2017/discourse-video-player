# name: discourse-video-player
# about: Adds support for m3u8 video files using Video.js player
# version: 0.1
# authors: Your Name
# url: https://github.com/yourusername/discourse-video-player

enabled_site_setting :video_player_enabled

register_asset "stylesheets/videojs-discourse.scss"
register_asset "javascripts/discourse/initializers/init-video-player.js.es6"

after_initialize do
  require_dependency "onebox/engine/video_onebox"

  class ::Onebox::Engine::VideoOnebox
    alias_method :old_to_html, :to_html
    
    def to_html
      if @url.match?(/\.m3u8(\?.*)?$/)
        "<div class='onebox video-onebox'><video class='video-js' controls preload='auto' width='100%' data-setup='{\"fluid\": true}'><source src='#{@url}' type='application/x-mpegURL'></video></div>"
      else
        old_to_html
      end
    end
  end
end
