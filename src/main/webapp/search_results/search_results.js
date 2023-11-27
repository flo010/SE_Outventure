// functions to check whether flags are true
let toastDataElements = document.getElementById('toastData');

if (toastDataElements) {
    let hikeCreated = toastDataElements.getAttribute('data-hike-created');
    let hikeDeleted = toastDataElements.getAttribute('data-hike-deleted');

    console.log(hikeCreated);
    console.log(hikeDeleted);

    if (hikeCreated === "true") {
        createToast("saveHikeToast", "Saving completed successfully", "Your hike was successfully saved!");
        showToast("saveHikeToast");
    }

    if (hikeDeleted === "true") {
        createToast("deleteHikeToast", "Deletion successfully completed", "Your hike was successfully deleted!");
        showToast("deleteHikeToast");
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
    var toastHeader = document.createElement("div");
    toastHeader.className = "toast-header";

    var strongElement = document.createElement("strong");
    strongElement.className = "me-auto";
    strongElement.innerText = headerMessage;
    var buttonElement = document.createElement("button");
    buttonElement.className = "btn-close";
    buttonElement.setAttribute("data-bs-dismiss", "toast");
    buttonElement.setAttribute("aria-label", "Close");

    toastHeader.appendChild(strongElement);
    toastHeader.appendChild(buttonElement);
    toast.appendChild(toastHeader);

    // Create toast body
    var toastBody = document.createElement("div");
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