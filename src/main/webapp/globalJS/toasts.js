let toastDataElements = document.getElementById('toastData');

if (toastDataElements) {
    let hikeCreated = toastDataElements.getAttribute('data-hike-created');
    let hikeDeleted = toastDataElements.getAttribute('data-hike-deleted');
    let hikeEdited = toastDataElements.getAttribute('data-hike-edited');

    console.log(hikeCreated);
    console.log(hikeDeleted);
    console.log(hikeEdited);

    if (hikeCreated === "true") {
        createStandardToast("saveHikeToast", "Saving completed successfully", "Your hike was successfully saved!");
        showToast("saveHikeToast");
    }

    if (hikeDeleted === "true") {
        createStandardToast("deleteHikeToast", "Deletion successfully completed", "Your hike was successfully deleted!");
        showToast("deleteHikeToast");
    }

    if (hikeEdited === "true") {
        createStandardToast("editHikeToast", "Editing successfully completed", "Your hike was successfully edited!");
        showToast("editHikeToast");
    }
}

function createStandardToast(id, headerMessage, bodyMessage) {
    let toast = document.createElement("div");
    toast.className = "toast position-fixed top-0 start-50 translate-middle-x";
    toast.id = id;
    toast.setAttribute("role", "alert");
    toast.setAttribute("aria-live", "assertive");
    toast.setAttribute("aria-atomic", "true");

    let toastHeader = document.createElement("div");
    toastHeader.className = "toast-header";

    let strongElement = document.createElement("strong");
    strongElement.className = "me-auto";
    strongElement.innerText = headerMessage;
    let buttonElement = document.createElement("button");
    buttonElement.className = "btn-close";
    buttonElement.setAttribute("data-bs-dismiss", "toast");
    buttonElement.setAttribute("aria-label", "Close");

    toastHeader.appendChild(strongElement);
    toastHeader.appendChild(buttonElement);
    toast.appendChild(toastHeader);

    let toastBody = document.createElement("div");
    toastBody.className = "toast-body";
    toastBody.innerText = bodyMessage;
    toast.appendChild(toastBody);

    document.body.appendChild(toast);
}


function createValidationToast(id, message) {
    let toastContainer = document.createElement('div');
    toastContainer.className = 'toast position-fixed bottom-0 end-0 align-items-center text-white bg-danger border-0';
    toastContainer.id = id;
    toastContainer.setAttribute('role', 'alert');
    toastContainer.setAttribute('aria-live', 'assertive');
    toastContainer.setAttribute('aria-atomic', 'true');

    let flexContainer = document.createElement('div');
    flexContainer.className = 'd-flex';

    let toastBody = document.createElement('div');
    toastBody.className = 'toast-body';
    toastBody.textContent = message;

    let closeButton = document.createElement('button');
    closeButton.type = 'button';
    closeButton.className = 'btn-close btn-close-white me-2 m-auto';
    closeButton.setAttribute('data-bs-dismiss', 'toast');
    closeButton.setAttribute('aria-label', 'Close');

    toastContainer.appendChild(flexContainer);
    flexContainer.appendChild(toastBody);
    flexContainer.appendChild(closeButton);

    document.body.appendChild(toastContainer);
}

function showToast(id) {
    let toast = new bootstrap.Toast(document.getElementById(id));
    toast.show();
}