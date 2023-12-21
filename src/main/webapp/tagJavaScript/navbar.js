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

function changeSelectedItem(item) {
    document.getElementById('selectedItem').innerText = item;

    var searchBar = document.getElementById('searchBar');

    switch (item) {
        case 'All':
            searchBar.placeholder = "All hikes";
            break;
        case 'Region':
            searchBar.placeholder = "All regions";
            break;
        case 'POI':
            searchBar.placeholder = " All Point of Interests";
            break;
        default:
            searchBar.placeholder = "All hikes";
            break;
    }
}