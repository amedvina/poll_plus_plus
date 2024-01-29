import consumer from "./consumer"

consumer.subscriptions.create("PollChannel", {
  connected() {
    console.log("test1")
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    console.log("test2")
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log("test3", data)
    // Called when there's incoming data on the websocket for this channel
  }
});
