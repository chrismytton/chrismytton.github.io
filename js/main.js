window.addEventListener("load", function() {
  new FastClick(document.body);

  // Hide the address bar on iOS - http://davidwalsh.name/hide-address-bar
  if (navigator.userAgent.match(/iPhone|iPad|iPod/)) {
    setTimeout(function() {
      window.scrollTo(0, 1);
    }, 0);
  }
}, false);
