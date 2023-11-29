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
    // Retrieve hikeList from the session
    var hikeList = document.getElementById('hikeList').value();

    // Perform any additional logic with the hikeList if needed

    // Redirect to the search results page
    window.location.href = "/search_results.jsp";
}