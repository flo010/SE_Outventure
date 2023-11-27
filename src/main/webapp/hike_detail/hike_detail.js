// delete hike functions
function deleteHike(hikeID) {
    // Redirect to the DeleteHikeServlet
    window.location.href = '../delete_hike?hikeID=' + hikeID;
}

function showDeleteHikeModal() {
    let deleteHikeModal = new bootstrap.Modal(document.getElementById('deleteHikeModal'), {
        keyboard: false
    });
    deleteHikeModal.show();
}

// function to fill circles for required strength, condition, ...
function fillCircles(count, startIndex) {
    let circles = Array.from(document.querySelectorAll('.fa.fa-circle-o'));
    for (let i = startIndex; ((i < startIndex + count) && (i < circles.length)); i += 1) {
        circles[i].classList.replace('fa-circle-o', 'fa-circle');
        circles[i].style.color = "#B6FC9D";
    }
}

document.addEventListener("DOMContentLoaded", function() {
    let hikeDataElement = document.getElementById('dataForCircles');

    if (hikeDataElement) {
        let stamina = parseInt(hikeDataElement.getAttribute('data-stamina'), 10);
        let strength = parseInt(hikeDataElement.getAttribute('data-strength'), 10);
        let experience = parseInt(hikeDataElement.getAttribute('data-experience'), 10);
        let landscape = parseInt(hikeDataElement.getAttribute('data-landscape'), 10);

        fillCircles(stamina, 0);
        fillCircles(strength, 5);
        fillCircles(experience, 10);
        fillCircles(landscape, 15);
    }
});


