emailPattern = /// ^ #begin of line
   ([\w.-]+)         #one or more letters, numbers, _ . or -
   @                 #followed by an @ sign
   ([\w.-]+)         #then one or more letters, numbers, _ . or -
   \.                #followed by a period
   ([a-zA-Z.]{2,6})  #followed by 2 to 6 letters or periods
   $ ///i            #end of line and ignore case

ready = ->
  $('.register-btn').click ->
    happen()

  $(document.body).keyup (ev) ->

    # 13 is ENTER
    happen() if ev.which is 13 and $('.email-field').is(":focus")

happen = ->
  if $('.email-field').val() == "SPAGETT"
    window.location.href = "https://kblanks.github.io/";

  unless $('.email-field').val().match emailPattern
    $('.alert').removeClass 'hidden'
    $('.alert').addClass 'alert-warning'
    $('.message').text "That is not a valid email address"
    $('#show-ip').addClass 'hidden'
    $('#confirmation').addClass 'hidden'
    $('#form').removeClass 'hidden'
    return

  console.log('line1')
  $('#show-ip').addClass 'hidden'
  $('#form').addClass 'hidden'
  $('#confirmation').removeClass 'hidden'
  $('.alert').addClass 'hidden'
  $('#error-true').addClass 'hidden'
  $('#email-confirm').text $('.email-field').val()
  console.log('line2')
  $('#continue-btn').click ->
    console.log('line3')
    $.getJSON '/tokens_controller', {email: $('.email-field').val()}, (data) ->
      console.log('line4')
      if data.error?
        console.log('line5')
        $('.alert').removeClass 'hidden'
        $('.alert').addClass 'alert-warning'
        $('.message').text data.error
        $('#show-ip').addClass 'hidden'
        $('#confirmation').addClass 'hidden'
        $('#form').removeClass 'hidden'
        return
      console.log('line6')
      $('#confirmation').addClass 'hidden'
      $('.alert').removeClass 'hidden'
      $('.alert').removeClass 'alert-warning'
      $('.alert').addClass 'alert-success'
      $('.message').text 'Your token has successfully been created.'
      $('#show-ip').removeClass 'hidden'
      $('#token').text "#{data.token}.register.hstrk.xyz"

      console.log($('.email-field').val())
      console.log(data)


$(document).on('page:load', ready)
