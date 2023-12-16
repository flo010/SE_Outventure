// delete hike functions
function deleteHike(hikeID) {
    // Redirect to the DeleteHikeServlet
    window.location.href = '../delete_hike?hikeID=' + hikeID;
}
function showDeleteHikeModal() {
    let deleteHikeModal = new bootstrap.Modal(document.getElementById('deleteHikeModal'), {
        keyboard: false
    });
    deleteHikeModal.show();
}
var selectedHikeID

function prepareDeleteHike(hikeId) {
    selectedHikeID = hikeId;
    showDeleteHikeModal();
}

function goToCreateHike(hikeID) {
    window.location.href = "/create/hike?hikeID=" + hikeID;
}