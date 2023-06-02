import { Controller } from "@hotwired/stimulus";

export default class ResultsController extends Controller {
  static targets = ["pollForm", "finalResult", "candidateButton"];

  async updateFinalResult(event) {
    event.preventDefault();

    const candidateId = event.target.getAttribute("data-candidate-id");

    try {
      const response = await fetch(`/votes`, {
        method: "POST",
        headers: {
          Accept: "application/json",
        },
        body: new URLSearchParams({
          "authenticity_token": document.querySelector('meta[name="csrf-token"]').getAttribute("content"),
          "vote[candidate_id]": candidateId,
        })
      })
      const data = await response.json();
      event.target.innerHTML = data.candidate.title_with_count;
    } catch (error) {
      console.log("error", error);
    }
  }
}
