import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['frame']

  connect() {
    this.pollForCompletion()
  }

  pollForCompletion() {
    const pollId = this.data.get('pollId')
    this.pollingInterval = setInterval(() => {
      this.checkCompletionStatus(pollId)
    }, 2000) // Poll every 2 seconds (adjust as needed)
  }

  checkCompletionStatus(pollId) {
    fetch(`/polls/${pollId}/completion_status`)
      .then(response => response.json())
      .then(data => {
        if (data.completed) {
          this.refreshResults()
          clearInterval(this.pollingInterval)
        }
      })
  }

  refreshResults() {
    this.frameTarget.innerHTML = '' // Clear existing content
    Turbo.visit(window.location.href, { action: 'replace' })
  }
}
console.log("outside")