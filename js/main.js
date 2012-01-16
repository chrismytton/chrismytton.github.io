jQuery(function ($) {
  var interval = null, count = 0;
  $(window).konami(function () {
    var timeout = 1500;
    // Shuffle randomly through multiple background colours in a psychedelic way
    interval = setInterval(function () {
      if (count > 30) {
        count = 0;
        $('body').stop(true).animate({'background-color': "rgb(255,255,255)"}, "slow", "linear");
        clearInterval(interval);
        return;
      }
      $('body').animate({'background-color': "rgb(" + [Math.floor(Math.random() * 255), Math.floor(Math.random() * 255), Math.floor(Math.random() * 255)].join(",") + ")"}, timeout, "linear");

      count += 1;
    }, timeout);
  });

  $('.date').timeago();
});
