import consumer from "./consumer"

consumer.subscriptions.create("PollChannel", {
  connected() {
    console.log("test1")
  },

  disconnected() {
    console.log("test2")
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log("test3", data)
    // Called when there's incoming data on the websocket for this channel
    if (data.processed === true) {
      console.log("test4")
      // location.reload();
      Turbo.visit(location.href, { action: 'replace', target: 'poll_final_result' });
    }
  }
});
