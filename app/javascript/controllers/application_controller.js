import { Controller } from "stimulus"

export default class extends Controller {
    static targets = ['modalContent', 'index']

    showModal(event) {
        event.preventDefault()
        fetch(event.currentTarget.getAttribute('href'))
            .then(response => response.text())
            .then(html => {
                this.modalContentTarget.innerHTML = html;
                $('#formModal').modal();
            })
    }

    submit(event) {
        let [xhr, status] = event.detail;
        if (status == 'OK') {
            this.indexTarget.innerHTML = xhr.response;
            $('#formModal').modal('hide');
        } else {
            this.modalContentTarget.innerHTML = xhr.response;
        }
    }

}
