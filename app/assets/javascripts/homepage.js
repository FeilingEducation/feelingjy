// toggle the menu based on active
$(document).on('click', '#sidebar .navbar-toggler', function () {
    sidebarOverlayOn();
    var btn_active = document.getElementById("sidebar").classList.toggle('active');
    if(!btn_active){
      sidebarOverlayOff();
    }
});

function sidebarOverlayOn() {
    var overlayClass = document.getElementById("sidebar-overlay");
    overlayClass.classList.remove("d-none");
    overlayClass.classList.add("d-block");
}

function sidebarOverlayOff() {
    var overlayClass = document.getElementById("sidebar-overlay");
    overlayClass.classList.remove("d-block");
    overlayClass.classList.add("d-none");
}

$(document).on('click', '#sidebar-overlay', function () {
    document.getElementById("sidebar").classList.toggle('active');
});







// if click on close button, remove src tag to close video
$(document).on('click', "#closeBtn", function () {
    document.querySelector("#videoModal").removeAttribute("src");
});

// if click on display button, add src tag to add video
$(document).on('click', ".footer-overlay .video_open", function () {
    document.querySelector("#videoModal").setAttribute("src", "//v.qq.com/x/page/o0608th1x9b.html");
});




$(document).on('click', '#place-order-resp', function () {
    requestOverlayOn();

    var myclass = document.getElementById("place-order-resp");
    myclass.className += " hide-request-btn";

    var requestMenu = document.getElementById("fixed-left-bar");
    requestMenu.classList.remove('d-none');

    var requestMenu = document.getElementById("fixed-left-bar");
    requestMenu.classList.add("d-block");
});


$(document).on('click', '#request-overlay', function () {
    var requestMenu = document.getElementById("fixed-left-bar");
    requestMenu.classList.remove('d-block');
});


function requestOverlayOn() {
    var overlayClass = document.getElementById("request-overlay");
    overlayClass.classList.remove("d-none");
    overlayClass.classList.add("d-block");
}

function requestOverlayOff() {
    var overlayClass = document.getElementById("request-overlay");
    overlayClass.classList.remove("d-block");
    overlayClass.classList.add("d-none");

    var myclass = document.getElementById("place-order-resp");
    myclass.classList.remove('hide-request-btn');
}

$(document).on('click', '#close-btn', function () {
    requestOverlayOff();
    var requestMenu = document.getElementById("fixed-left-bar");
    requestMenu.classList.remove('d-block');
});
