import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["processedResults"]

  connect() {
    console.log("connected");

    this.startPolling();
  }

  startPolling() {
    this.pollInterval = setInterval(() => {
      this.checkPollStatus();
    }, 1000);
  }

  stopPolling() {
    clearInterval(this.pollInterval);
  }

  checkPollStatus() {
    const isPollProcessed = this.data.get("pollProcessed");

    if (isPollProcessed) {
      console.log("Is Active: true");

      this.stopPolling();
      location.reload();
    }
  }

  disconnect() {
    this.stopPolling();
  }
}
