// toggle the menu based on active
$(document).on('click', '#sidebar .navbar-toggler', function () {
    document.getElementById("sidebar").classList.toggle('active');
});

// if click on close button, remove src tag to close video
$(document).on('click', '#closeBtn', function () {
    document.querySelector("#videoModal").removeAttribute("src");
});

// if click on display button, add src tag to add video
$(document).on('click', '#myModal', function () {
    document.querySelector("#videoModal").setAttribute("src", "//www.youtube.com/embed/Rf7dAfEccmo");
});
