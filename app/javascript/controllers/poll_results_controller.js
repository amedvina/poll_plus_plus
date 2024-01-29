import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["processedResults"]

  connect() {
    console.log("connected");

    this.startPollResultProcess();
  }

  startPollResultProcess() {
    this.pollInterval = setTimeout(() => {
      this.checkPollStatus();
    }, 1000);
  }

  stopPollResultProcess() {
    clearTimeout(this.pollInterval);
  }

  checkPollStatus() {
    const pollId = this.data.get("pollId");
    fetch(`/polls/${pollId}.json`)
    .then(response => response.json())
    .then(data => {
      if (data.is_processed === true) {
        // location.reload();

        Turbo.visit(location.href, { action: 'replace', target: 'poll_final_result' });
        this.stopPollResultProcess();
      }
    });
  }
}
