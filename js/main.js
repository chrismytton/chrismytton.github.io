// Hide the address bar on iOS - http://davidwalsh.name/hide-address-bar
window.addEventListener("load", function() {
  setTimeout(function() {
    window.scrollTo(0, 1);
  }, 0);
});
