import { withPluginApi } from "discourse/lib/plugin-api";

function initializeVideoPlayer(api) {
  api.onPageChange(() => {
    const videoElements = document.querySelectorAll('video.video-js');
    videoElements.forEach(video => {
      if (!video.player) {
        videojs(video);
      }
    });
  });
}

export default {
  name: "init-video-player",
  initialize(container) {
    withPluginApi("0.8.31", initializeVideoPlayer);
  }
};
