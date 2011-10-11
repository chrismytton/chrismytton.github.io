(function($) {
  return $.fn.konami = function(callback, code) {
    code || (code = "38,38,40,40,37,39,37,39,66,65");
    return this.each(function() {
      var kkeys;
      kkeys = [];
      return $(this).keydown(function(e) {
        kkeys.push(e.keyCode);
        if (kkeys.toString().indexOf(code) >= 0) {
          kkeys = [];
          return callback(e);
        }
      });
    });
  };
})(jQuery);
