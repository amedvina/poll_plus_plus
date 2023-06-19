// import { Controller } from "@hotwired/stimulus";
//
// export default class ResultsController extends Controller {
//   static targets = ["finalResult"];
//
//   async updateFinalResult(event) {
//     event.preventDefault();
//
//     const candidateId = event.target.getAttribute("data-candidate-id");
//
//     try {
//       const response = await fetch(`/votes`, {
//         method: "POST",
//         headers: {
//           Accept: "application/json",
//         },
//         body: new URLSearchParams({
//           "authenticity_token": document.querySelector('meta[name="csrf-token"]').getAttribute("content"),
//           "vote[candidate_id]": candidateId,
//         })
//       })
//       const data = await response.json();
//       event.target.innerHTML = data.candidate.title_with_count;
//       this.finalResultTarget.innerHTML = data.final_result.winners;
//
//     } catch (error) {
//       console.log("error", error);
//     }
//   }
// }
