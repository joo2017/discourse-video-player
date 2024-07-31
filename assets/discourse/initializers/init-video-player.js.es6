import { withPluginApi } from "discourse/lib/plugin-api";
import loadScript from "discourse/lib/load-script";

function initializeVideoPlayer(api) {
  api.onPageChange(() => {
    const videoElements = document.querySelectorAll('.video-js');
    if (videoElements.length > 0) {
      loadScript("https://vjs.zencdn.net/7.20.3/video.min.js").then(() => {
        videoElements.forEach(video => {
          if (!video.id) video.id = `vjs-${Math.random().toString(36).substr(2, 9)}`;
          if (!videojs.getPlayers()[video.id]) {
            videojs(video.id);
          }
        });
      });
    }
  });
}

export default {
  name: "init-video-player",
  initialize() {
    withPluginApi("0.8.31", initializeVideoPlayer);
  }
};
