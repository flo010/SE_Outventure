function clearSearchString() {
    let searchBar = document.getElementById("searchBar");
    searchBar.value = "";

    // Make an AJAX call to update the searchString in the session
    let xhr = new XMLHttpRequest();
    xhr.open("POST", "/search_results", true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            console.log("Search string updated successfully");
        }
    };
    xhr.send("clearedSearchString=");
}

function logout() {
    document.getElementById('logoutForm').submit();
}