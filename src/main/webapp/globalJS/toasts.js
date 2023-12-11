// functions to check whether flags are true
let toastDataElements = document.getElementById('toastData');

if (toastDataElements) {
    let hikeCreated = toastDataElements.getAttribute('data-hike-created');
    let hikeDeleted = toastDataElements.getAttribute('data-hike-deleted');
    let hikeEdited = toastDataElements.getAttribute('data-hike-edited');

    console.log(hikeCreated);
    console.log(hikeDeleted);
    console.log(hikeEdited);

    if (hikeCreated === "true") {
        createToast("saveHikeToast", "Saving completed successfully", "Your hike was successfully saved!");
        showToast("saveHikeToast");
    }

    if (hikeDeleted === "true") {
        createToast("deleteHikeToast", "Deletion successfully completed", "Your hike was successfully deleted!");
        showToast("deleteHikeToast");
    }

    if (hikeEdited === "true") {
        createToast("editHikeToast", "Editing successfully completed", "Your hike was successfully edited!");
        showToast("editHikeToast");
    }
}

// toast functions
function createToast(id, headerMessage, bodyMessage) {
    // Create a new toast element
    let toast = document.createElement("div");
    toast.className = "toast position-fixed top-0 start-50 translate-middle-x";
    toast.id = id;
    toast.setAttribute("role", "alert");
    toast.setAttribute("aria-live", "assertive");
    toast.setAttribute("aria-atomic", "true");

    // Create toast header
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

    // Create toast body
    let toastBody = document.createElement("div");
    toastBody.className = "toast-body";
    toastBody.innerText = bodyMessage;
    toast.appendChild(toastBody);

    // Append the toast to the body
    document.body.appendChild(toast);
}

function showToast(id) {
    let toast = new bootstrap.Toast(document.getElementById(id));
    toast.show();
}