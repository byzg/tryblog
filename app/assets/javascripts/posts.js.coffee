$ ->
  txta = $("textarea#post_content")
  sbjt = $('input#post_subject')
  fnps = $('form#current1_post')
  ddtr = $('#form_block_submit #dropdown_triangle')
  sbbt = $('input[type="submit"]#submit_current1_post')
  waiting_post_id = null
  save_list_cancel = $('#save_list .save_list_point.cancel')
  save_list_no = $("#save_list .save_list_point.no")
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
  current_post_saved = (with_saved_verification) ->
    return true unless with_saved_verification
    action = fnps.attr('action')
    if action == "/posts" && fnps.attr('method') == 'post'
      return sbjt.val().length + txta.val().length == 0
    else
      post_data = post_find_by_id(id_from_string_with_id(action))
      return sbjt.val() == post_data["subject"] && txta.val() == post_data["content"]
  updating_current_post = (post_data, opt = {with_saved_verification: true}) ->
    subject = post_data["subject"]; content = post_data["content"]; post_id = post_data["post_id"]
    if current_post_saved(opt["with_saved_verification"])
      sbjt.val(subject)
      txta.val(content)
      editing_mode_post(post_id)
    else
      saving_current_post(true)
  post_find_by_id = (id) ->
    post = $(".challenge-instructions #post_block_#{id} .post")
    subject = post.children('.post_subject').text()
    content = post.children('.post_content').text()
    {subject: subject, content: content, post_id: id}
  doing_with_press_yes_or_no_or_cancel_on_save_list = (with_update = true) ->
    saving_current_post(false)
    if waiting_post_id
      updating_current_post(post_find_by_id(waiting_post_id), "with_saved_verification": false) if with_update
      waiting_post_id = null
  id_from_string_with_id = (str) ->
    str.match(/\d+/).toString()
  if fnps.length
    txta.focus()
    sbjt_plhd = sbjt.attr('placeholder')
    sbjt.focus ->
      sbjt.attr('placeholder', '')
    sbjt.blur ->
      sbjt.attr('placeholder', sbjt_plhd)
  $('.challenge-instructions').delegate(".post_block", "click", ->
    post_id = id_from_string_with_id($(this).attr('id'))
    updating_current_post(post_find_by_id(post_id))
    waiting_post_id = post_id unless post_id == id_from_string_with_id(fnps.attr('action'))
  )
  ddtr.focusin ->
    turn_triangle()
  ddtr.focusout ->
    turn_triangle()
  ddtr.click ->
    turn_triangle()
    if ddtr.text() == "▼" then saving_current_post(true) else saving_current_post(false)
  fnps.submit ->
    setTimeout (->
      doing_with_press_yes_or_no_or_cancel_on_save_list()
    ), 100
  save_list_cancel.click ->
    doing_with_press_yes_or_no_or_cancel_on_save_list(false)
  save_list_no.click ->
    doing_with_press_yes_or_no_or_cancel_on_save_list()



