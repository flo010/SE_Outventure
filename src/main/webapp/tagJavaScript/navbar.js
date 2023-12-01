function commitSearch(event) {
    event.preventDefault(); // Prevent the default action of the anchor tag

    // You can perform additional operations here before submitting the form if needed

    document.getElementById("search-input").submit(); // Submit the form
}