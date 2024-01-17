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
    const durationLow = document.getElementById("durationLow").value;
    const durationHigh = document.getElementById("durationHigh").value;
    const distanceLow = document.getElementById("distanceLow").value;
    const distanceHigh = document.getElementById("distanceHigh").value;
    const altitudeLow = document.getElementById("altitudeLow").value;
    const altitudeHigh = document.getElementById("altitudeHigh").value;
    const staminaLow = document.getElementById("staminaLow").value;
    const staminaHigh = document.getElementById("staminaHigh").value;
    const powerLow = document.getElementById("powerLow").value;
    const powerHigh = document.getElementById("powerHigh").value;
    const experienceLow = document.getElementById("experienceLow").value;
    const experienceHigh = document.getElementById("experienceHigh").value;
    const landscapeLow = document.getElementById("landscapeLow").value;
    const landscapeHigh = document.getElementById("landscapeHigh").value;
    const month = filters.months; // Assuming 'filters' is defined elsewhere

    const currentUrl = window.location.href;

    // Construct the new URL with updated parameters
    const newParameters = `&durationLow=${durationLow}&durationHigh=${durationHigh}&distanceLow=${distanceLow}&distanceHigh=${distanceHigh}&altitudeLow=${altitudeLow}&altitudeHigh=${altitudeHigh}&staminaLow=${staminaLow}&staminaHigh=${staminaHigh}&powerLow=${powerLow}&powerHigh=${powerHigh}&experienceLow=${experienceLow}&experienceHigh=${experienceHigh}&landscapeLow=${landscapeLow}&landscapeHigh=${landscapeHigh}&month=${month}`;
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
            addsearchMonth(i);
        }
    }
}

function resetFilters() {
    location.href = location.href.split("&")[0];
}