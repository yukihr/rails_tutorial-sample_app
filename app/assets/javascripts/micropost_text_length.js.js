// Generated by CoffeeScript 1.3.3
(function() {

  $(function() {
    var count, textarea;
    textarea = $('#micropost_content');
    count = $('#micropost_count');
    count.css('color', '#CCC');
    return textarea.on('input', function(ev) {
      var delta;
      delta = 140 - parseInt(ev.target.value.length, 10);
      count.text(delta);
      if (delta < 10) {
        return count.css('color', 'red');
      } else if (delta < 20) {
        return count.css('color', '#111');
      } else {
        return count.css('color', '#CCC');
      }
    });
  });

}).call(this);