function commitSearch(event) {
    event.preventDefault(); // Prevent the default action of the anchor tag

    document.getElementById("search-input").submit(); // Submit the form
}

function clearSearchValue() {
    document.getElementById("searchBar").value = "";
    console.log("function is called");
}