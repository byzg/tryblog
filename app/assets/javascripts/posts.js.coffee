$ ->
  txta = $("textarea#post_content")
  sbjt = $('input#post_subject')
  fnps = $('form#current1_post')
  ddtr = $('#form_block_submit #dropdown_triangle')
  sbbt = $('input[type="submit"]#submit_current1_post')
  window.editing_mode_post = (post_id) ->
    fnps.attr('action', "/posts/#{post_id}");
    fnps.attr('method', 'put');
  saving_current_post = (show) ->
    if show
      display = 'block'; visibility = 'visible'; border_radius = '10px 10px 0 0'
    else
      display = 'none'; visibility = 'hidden'; border_radius = '10px'
    $('#save_confirm_label').css('visibility', visibility)
    $('#save_list').css('display', display)
    sbbt.css('border-radius', border_radius)
  turn_triangle = () ->
    ddtr.text(if ddtr.text() == "▼" then "▲" else "▼")
  current_post_saved = (subject, content, post_id) ->
    if fnps.attr('action') == "/posts" && fnps.attr('method') == 'post'
      return sbjt.val().length + txta.val().length == 0
    else
      return sbjt.val() == subject && txta.val() == content && fnps.attr('action').match(/(\d)+/g) == post_id
  updating_current_post = (subject, content, post_id) ->
    if current_post_saved(subject, content, post_id)
      sbjt.val(subject)
      txta.val(content)
      editing_mode_post(post_id)
    else
      saving_current_post(true)
  if fnps.length
    txta.focus()
    sbjt_plhd = sbjt.attr('placeholder')
    sbjt.focus ->
      sbjt.attr('placeholder', '')
    sbjt.blur ->
      sbjt.attr('placeholder', sbjt_plhd)
  if $('.post_block').length
    $('.post_block').click ->
      post = $("##{$(this).attr('id')} .post")
      subject = post.children('.post_subject').text()
      content = post.children('.post_content').text()
      post_id = $(this).attr('id')[11..-1]
      updating_current_post(subject, content, post_id)
  ddtr.focusin ->
    turn_triangle()
  ddtr.focusout ->
    turn_triangle()
  ddtr.click ->
    turn_triangle()
    if ddtr.text() == "▼" then saving_current_post(true) else saving_current_post(false)
  sbbt.click ->
    saving_current_post(false)

