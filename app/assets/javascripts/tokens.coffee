ready = ->
  $('.register-btn').click ->
    if $('.email-field').val() == "SPAGETT"
      window.location.href = "https://kblanks.github.io/";
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
        $('#token').text "#{data.token}.register.hungerstruck.net"

        console.log($('.email-field').val())
        console.log(data)


$(document).on('page:load', ready)
