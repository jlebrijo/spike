import { Controller } from "stimulus"

export default class extends Controller {
    static targets = ["modalContent"]

    showModal(e) {
        e.preventDefault()
        fetch(e.currentTarget.getAttribute('href'))
            .then(response => response.text())
            .then(html => {
                this.modalContentTarget.innerHTML = html;
                $('#formModal').modal();
            })
    }

    submitForm(event) {
        let [data, status, xhr] = event.detail;
        this.modalContentTarget.innerHTML = xhr.response;
    }

}
