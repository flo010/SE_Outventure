const filters = {
    months: 0,
};
const months = document.getElementsByClassName("clickable");
function addsearchMonth(exponent) {
    if (months[exponent].firstElementChild.style.backgroundColor === "") {
        filters.months += Math.pow(2, exponent);
        months[exponent].firstElementChild.style.backgroundColor = "#b6fc9d";
        console.log(filters.months);
    } else {
        filters.months -= Math.pow(2, exponent);
        months[exponent].firstElementChild.style.backgroundColor = "";
        console.log(filters.months);
    }
}

function getFiltered() {
    const durationLow = document.getElementById("DurationLow").value;
    const durationHigh = document.getElementById("DurationHigh").value;
    const distanceLow = document.getElementById("DistanceLow").value;
    const distanceHigh = document.getElementById("DistanceHigh").value;
    const altitudeLow = document.getElementById("AltitudeLow").value;
    const altitudeHigh = document.getElementById("AltitudeHigh").value;
    const staminaLow = document.getElementById("StaminaLow").value;
    const staminaHigh = document.getElementById("StaminaHigh").value;
    const powerLow = document.getElementById("PowerLow").value;
    const powerHigh = document.getElementById("PowerHigh").value;
    const experienceLow = document.getElementById("ExperienceLow").value;
    const experienceHigh = document.getElementById("ExperienceHigh").value;
    const landscapeLow = document.getElementById("LandscapeLow").value;
    const landscapeHigh = document.getElementById("LandscapeHigh").value;
    const month = filters.months; // Assuming 'filters' is defined elsewhere

    // Get the current URL
    const currentUrl = window.location.href;

    // Construct the new URL with updated parameters
    const newParameters = `&durationLow=${durationLow}&durationHigh=${durationHigh}&distanceLow=${distanceLow}&distanceHigh=${distanceHigh}&altitudeLow=${altitudeLow}&altitudeHigh=${altitudeHigh}&staminaLow=${staminaLow}&staminaHigh=${staminaHigh}&powerLow=${powerLow}&powerHigh=${powerHigh}&experienceLow=${experienceLow}&experienceHigh=${experienceHigh}&landscapeLow=${landscapeLow}&landscapeHigh=${landscapeHigh}&month=${month}`;
    // Redirect the user to the new URL
    window.location.href = currentUrl.split("&")[0] + newParameters;
}


// Get references to the checkbox and the content div
const toggleSwitch = document.getElementById("monthSwitch");
const contentToHide = document.getElementById("months");
const arrowDown = document.getElementById("MonthArrowDown");
const arrowUp = document.getElementById("MonthArrowUp");

// Add event listener to checkbox to toggle visibility of the content
toggleSwitch.addEventListener("change", function () {
    console.log("Test");
    if (this.checked) {
        contentToHide.style.display = "flex"; // Hide the content
        arrowUp.style.display = "";
        arrowDown.style.display = "none";
    } else {
        contentToHide.style.display = "none"; // Show the content
        arrowUp.style.display = "none";
        arrowDown.style.display = "";
    }
});

function resetFilters() {
    location.href = location.href.split("&")[0];
}