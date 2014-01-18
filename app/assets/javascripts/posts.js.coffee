$ ->
  $( document ).ready ->
    txta = $("textarea#post_content")
    sbjt = $('input#post_subject')
    if $('form#new_post').length
      txta.focus()
      sbjt_plhd = sbjt.attr('placeholder')
      sbjt.focus ->
        sbjt.attr('placeholder', '')
      sbjt.blur ->
        sbjt.attr('placeholder', sbjt_plhd)
      $('input[type="submit"]').click ->
        setTimeout(
          ->
            txta.val("")
            sbjt.val("")
          , 100
        )
