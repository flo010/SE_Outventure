function deleteHike(hikeID) {
    // Redirect to the DeleteHikeServlet
    window.location.href = 'delete_hike?hikeID=' + hikeID;
}

function showDeleteHikeModal() {
    let deleteHikeModal = new bootstrap.Modal(document.getElementById('deleteHikeModal'), {
        keyboard: false
    });
    deleteHikeModal.show();
}

function showLastSearchResults() {
    window.location.href = "/search_results.jsp";
}