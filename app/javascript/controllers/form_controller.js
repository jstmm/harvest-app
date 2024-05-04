import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  // static targets = [ "animation", "image", "contents", "noResults" ]
  // static animationUrl = null

  connect() {
    // debugger
    // this.animationUrl = this.imageTarget.src
    // this.form = this.element
  }

  submitForm() {
    // let table = document.querySelector('[data-controller="table"]')
    // if (table) {
    //   table.dispatchEvent(new CustomEvent('formsubmitted'))
    // }
    // this.form.requestSubmit()
  }

  showAnimation(event) {
    // event.preventDefault();
    // this.imageTarget.src = this.animationUrl + '?a=' + Math.random() // To reset the animation
    // this.animationTarget.classList.remove('hidden')
    // if (this.hasNoResultsTarget) {
    //   this.noResultsTarget.classList.add('hidden')
    // }
    // this.contentsTarget.innerHTML = ""
  }
}
