import { withPluginApi } from "discourse/lib/plugin-api";

function initializeVideoPlayer(api) {
  api.onPageChange(() => {
    setTimeout(() => {
      const domList = document.querySelectorAll('.video-js');
      domList.forEach((ele) => {
        const player = videojs(ele);
        player.ready(function() {
          console.log("Player is ready!");
        });
      });
    }, 200);
  });
}

export default {
  name: "init-video-player",
  initialize() {
    withPluginApi("0.8.31", initializeVideoPlayer);
  }
};