$ ->
  txta = $("textarea#post_content")
  sbjt = $('input#post_subject')
  fnps = $('form#current1_post')
  ddtr = $('#form_block_submit #dropdown_triangle')
  sbbt = $('button#submit_current1_post')
  waiting_post_id = null
  save_list_cancel = $('#save_list .save_list_point.cancel')
  save_list_no = $("#save_list .save_list_point.no")
  window.editing_mode_post = (post_id) ->
    fnps.attr('action', "/posts/#{post_id}");
    fnps.attr('method', 'put');
  hidden_locales = (key) ->
    $("#hidden_locales .#{key}").text()

  post_focus = ->
    txta.focus()
  if fnps.length
    post_focus()
  newing_mode_post = ->
    sbjt.val('');   txta.val(''); fnps.attr('action', "/posts");
    fnps.attr('method', 'post'); post_focus()
    sbjt.attr('placeholder', hidden_locales('subject_placeholder_new'))

# show==true - показать диалог, иначе  - скрыть
  saving_current_post = (show) ->
    if show
      display = 'block'; visibility = 'visible';
      border_radius = '10px 10px 0 0'; submit_value = 'yes'
    else
      display = 'none'; visibility = 'hidden';
      border_radius = '10px'; submit_value = 'save'
    $('#alert_block #save_confirm').css('visibility', visibility)
    $('#save_list').css('display', display)
    sbbt.css('border-radius', border_radius)
    sbbt.val(hidden_locales(submit_value))

  turn_triangle = () ->
    ddtr.text(if ddtr.text() == "▼" then "▲" else "▼")

  current_post_new = ->
    fnps.attr('action') == "/posts" && fnps.attr('method') == 'post'

  current_post_saved = (with_saved_verification = true) ->
    return true unless with_saved_verification
    if current_post_new()
      return sbjt.val().length + txta.val().length == 0
    else
      post_data = post_find_by_id(id_from_string_with_id(fnps.attr('action')))
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
    if with_update
      if waiting_post_id.match(/^\d+$/)
        updating_current_post(post_find_by_id(waiting_post_id), "with_saved_verification": false) if  with_update
      else if waiting_post_id == 'NEW'
        newing_mode_post()
    waiting_post_id = null if waiting_post_id

  id_from_string_with_id = (str) ->
    str.match(/\d+$/).toString()

  $('.challenge-instructions').delegate(".post_block", "click", ->
    sbjt.attr('placeholder', hidden_locales('subject_placeholder')) if current_post_new()
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

  sbbt.click ->
    fnps.submit()
    doing_with_press_yes_or_no_or_cancel_on_save_list()
  save_list_cancel.click ->
    doing_with_press_yes_or_no_or_cancel_on_save_list(false)
  save_list_no.click ->
    doing_with_press_yes_or_no_or_cancel_on_save_list()

  $('#form_block_new_post').click ->
    if current_post_saved()
      newing_mode_post()
    else
      waiting_post_id = 'NEW'
      saving_current_post(true)



