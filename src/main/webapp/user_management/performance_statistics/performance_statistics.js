let fromDate = document.getElementById("fromDate");
let toDate = document.getElementById("toDate");

function resetFilters() {
    fromDate.value = '';
    toDate.value = '';
}

function setCurrentMonth() {
    let today = new Date();
    let firstDayOfMonth = new Date(today.getFullYear(), today.getMonth(), 1);

    fromDate.value = formatDate(firstDayOfMonth);
    toDate.value = formatDate(today);
}

function setCurrentYear() {
    let today = new Date();
    let firstDayOfYear = new Date(today.getFullYear(), 0, 1);

    fromDate.value = formatDate(firstDayOfYear);
    toDate.value = formatDate(today);
}

function setEntirePeriod() {
    // Set a distant past date (e.g., 01.01.1900)
    let startDate = new Date(1900, 0, 1);

    // Set today's date
    let endDate = new Date();

    fromDate.value = formatDate(startDate);
    toDate.value = formatDate(endDate);
}

function formatDate(date) {
    let day = date.getDate();
    let month = date.getMonth() + 1;
    let year = date.getFullYear();

    day = day < 10 ? '0' + day : day;
    month = month < 10 ? '0' + month : month;

    return year + '-' + month + '-' + day;
}
