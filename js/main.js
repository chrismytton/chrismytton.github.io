jQuery(function ($) {
  var interval = null, count = 0;
  $(window).konami(function () {
    // Shuffle randomly through multiple background colours in a psycadelic way
    interval = setInterval(function () {
      if (count > 30) {
        count = 0;
        $('body').stop(true).animate({'background-color': "rgb(255,255,255)"}, "slow", "linear");
        clearInterval(interval);
        return;
      }
      $('body').animate({'background-color': "rgb(" + [Math.floor(Math.random() * 255), Math.floor(Math.random() * 255), Math.floor(Math.random() * 255)].join(",") + ")"}, 500, "linear");

      count += 1;
    }, 500);
  });
});
