const filters = {
    months: 0,
};
const months = document.getElementsByClassName("clickable");
function addSearchMonth(exponent) {
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
    const strengthLow = document.getElementById("StrengthLow").value;
    const strengthHigh = document.getElementById("StrengthHigh").value;
    const experienceLow = document.getElementById("ExperienceLow").value;
    const experienceHigh = document.getElementById("ExperienceHigh").value;
    const landscapeLow = document.getElementById("LandscapeLow").value;
    const landscapeHigh = document.getElementById("LandscapeHigh").value;
    const month = filters.months; // Assuming 'filters' is defined elsewhere

    const currentUrl = window.location.href;

    // Construct the new URL with updated parameters
    const newParameters = `&durationLow=${durationLow}&durationHigh=${durationHigh}&distanceLow=${distanceLow}&distanceHigh=${distanceHigh}&altitudeLow=${altitudeLow}&altitudeHigh=${altitudeHigh}&staminaLow=${staminaLow}&staminaHigh=${staminaHigh}&StrengthLow=${strengthLow}&StrengthHigh=${strengthHigh}&experienceLow=${experienceLow}&experienceHigh=${experienceHigh}&landscapeLow=${landscapeLow}&landscapeHigh=${landscapeHigh}&month=${month}`;
    // Redirect the user to the new URL
    window.location.href = currentUrl.split("&")[0] + newParameters;
}


const toggleSwitch = document.getElementById("monthSwitch");
const contentToHide = document.getElementById("months");
const arrowDown = document.getElementById("monthArrowDown");
const arrowUp = document.getElementById("monthArrowUp");

toggleSwitch.addEventListener("change", function () {
    console.log("Test");
    if (this.checked) {
        contentToHide.style.display = "flex"; // Show the content
        arrowUp.style.display = "";
        arrowDown.style.display = "none";
    } else {
        contentToHide.style.display = "none"; // Hide the content
        arrowUp.style.display = "none";
        arrowDown.style.display = "";
    }
});

let initMonths = parseInt(document.getElementById("monthData").getAttribute("data-months-value"));

if (initMonths !== 0 && !isNaN(initMonths)) {
    contentToHide.style.display = "flex";
    arrowUp.style.display = "";
    arrowDown.style.display = "none";

    for (let i = 0; i < 12; i++) {
        let mask = 1 << i;

        if ((initMonths & mask) !== 0) {
            addSearchMonth(i);
        }
    }
}

function resetFilters() {
    location.href = location.href.split("&")[0];
}