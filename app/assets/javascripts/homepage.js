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
    $("#place-order-resp").addClass("hide-request-btn");
    $("#request-overlay").removeClass("d-none").addClass("d-block");
    $("#fixed-left-bar").removeClass("d-none").addClass("d-block");
});

$(document).on('click', '#request-overlay', function () {
    $("#fixed-left-bar").removeClass("d-block");
    $("#request-overlay").removeClass("d-block").addClass("d-none");
    $("#place-order-resp").removeClass("hide-request-btn");
});

$(document).on('click', '#close-btn', function () {
    $("#request-overlay").removeClass("d-block").addClass("d-none");
    $("#place-order-resp").removeClass("hide-request-btn");
    $("#fixed-left-bar").removeClass("d-block");
});


$(document).on('click', '#about_me_nav', function () {
  // Make sure this.hash has a value before overriding default behavior
  if (this.hash !== "") {
    // Prevent default anchor click behavior
    event.preventDefault();
    // Store hash
    var hash = this.hash;
    // Using jQuery's animate() method to add smooth page scroll
    // The optional number (500) specifies the number of milliseconds it takes to scroll to the specified area
    $('html, body').animate({
      scrollTop: $(hash).offset().top
    }, 500, function(){
      // Add hash (#) to URL when done scrolling (default click behavior)
      window.location.hash = hash;
    });
  } // End if
});

$(document).on('click', '#universities_nav', function () {
  // Make sure this.hash has a value before overriding default behavior
  if (this.hash !== "") {
    // Prevent default anchor click behavior
    event.preventDefault();
    // Store hash
    var hash = this.hash;
    // Using jQuery's animate() method to add smooth page scroll
    // The optional number (500) specifies the number of milliseconds it takes to scroll to the specified area
    $('html, body').animate({
      scrollTop: $(hash).offset().top
    }, 500, function(){
      // Add hash (#) to URL when done scrolling (default click behavior)
      window.location.hash = hash;
    });
  } // End if
});

$(document).on('click', '#costs_nav', function () {
  // Make sure this.hash has a value before overriding default behavior
  if (this.hash !== "") {
    // Prevent default anchor click behavior
    event.preventDefault();
    // Store hash
    var hash = this.hash;
    // Using jQuery's animate() method to add smooth page scroll
    // The optional number (500) specifies the number of milliseconds it takes to scroll to the specified area
    $('html, body').animate({
      scrollTop: $(hash).offset().top
    }, 500, function(){
      // Add hash (#) to URL when done scrolling (default click behavior)
      window.location.hash = hash;
    });
  } // End if
});

$(document).on('click', '#education_nav', function () {
  // Make sure this.hash has a value before overriding default behavior
  if (this.hash !== "") {
    // Prevent default anchor click behavior
    event.preventDefault();
    // Store hash
    var hash = this.hash;
    // Using jQuery's animate() method to add smooth page scroll
    // The optional number (500) specifies the number of milliseconds it takes to scroll to the specified area
    $('html, body').animate({
      scrollTop: $(hash).offset().top
    }, 500, function(){
      // Add hash (#) to URL when done scrolling (default click behavior)
      window.location.hash = hash;
    });
  } // End if
});
