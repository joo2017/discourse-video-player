# name: discourse-video-player
# about: Adds support for m3u8 video files using Video.js player
# version: 0.1
# authors: Your Name
# url: https://github.com/yourusername/discourse-video-player

enabled_site_setting :video_player_enabled

register_asset 'javascripts/discourse/initializers/init-video-player.js.es6'

after_initialize do
  require_dependency 'onebox/engine/video_onebox'
  
  class ::Onebox::Engine::VideoOnebox
    matches_regexp(%r{^(https?:)?//.*\.(mov|mp4|webm|ogv|m3u8)(\?.*)?$}i)

    def to_html
      if @url.match(%r{\.m3u8$})
        randomId = Time.now.to_i.to_s + rand(100000000).to_s
        <<-HTML
          <div class="onebox video-onebox videoWrap">
            <video id='#{randomId}' class="video-js vjs-default-skin vjs-16-9" controls preload="auto" width="100%" data-setup='{"fluid": true}'>
              <source src="#{@url}" type="application/x-mpegURL">
            </video>
          </div>
        HTML
      else
        escaped_url = ::Onebox::Helpers.normalize_url_for_output(@url)
        <<-HTML
          <div class="onebox video-onebox">
            <video width='100%' height='100%' controls #{@options[:disable_media_download_controls] ? 'controlslist="nodownload"' : ""}>
              <source src='#{escaped_url}'>
              <a href='#{escaped_url}'>#{@url}</a>
            </video>
          </div>
        HTML
      end
    end
  end
end