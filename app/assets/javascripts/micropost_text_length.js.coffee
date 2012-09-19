$ ->
  textarea = $('#micropost_content')
  count = $('#micropost_count')
  count.css('color', '#CCC')
  textarea.on 'input', (ev) ->
    delta = 140 - parseInt(ev.target.value.length, 10)
    count.text(delta)
    if delta < 10
      count.css('color', 'red')
    else if delta < 20
      count.css('color', '#111')
    else
      count.css('color', '#CCC')
