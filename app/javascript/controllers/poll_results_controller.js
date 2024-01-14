import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["processedResults"]

  connect() {
    console.log("connected");

    this.startPollProcessing();
  }

  startPollProcessing() {
    this.pollInterval = setInterval(() => {
      this.checkPollStatus();
    }, 1000);
  }

  stopPollProcessing() {
    clearInterval(this.pollInterval);
  }

  checkPollStatus() {
    const isPollProcessed = this.data.get("pollProcessed");

    if (isPollProcessed) {
      console.log("Is Active: true");

      this.stopPollProcessing();
      location.reload();
    }
  }

  disconnect() {
    this.stopPolling();
  }
}
