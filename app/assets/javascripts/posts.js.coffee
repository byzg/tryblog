$ ->
  txta = $("textarea#post_content")
  sbjt = $('input#post_subject')
  fnps = $('form#new_post')
  window.editing_mode_post = (post_id) ->
    fnps.attr('action', "/posts/#{post_id}");
    fnps.attr('method', 'put');
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
      sbjt.val(post.children('.post_subject').text())
      txta.val(post.children('.post_content').text())
      editing_mode_post($(this).attr('id')[11..-1])