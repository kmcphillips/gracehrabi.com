$ ->
  $('body').prepend('<div id="fb-root"></div>')

  ((d, s, id) ->
    js = undefined
    fjs = d.getElementsByTagName(s)[0]
    return  if d.getElementById(id)
    js = d.createElement(s)
    js.id = id
    js.src = "//connect.facebook.net/en_US/all.js"
    fjs.parentNode.insertBefore js, fjs
  )(document, "script", "facebook-jssdk")

  $(document).on 'click', '[data-publish-facebook-event]', ->
    window.fbEventId = $(this).attr('data-publish-facebook-event')
    window.fbWithLogin(fbEventPublishConfirm)
    return false

window.fbAsyncInit = ->
  FB.init
    appId: "1432179167001171"
    channelUrl: "//localhost:3003/channel.html"
    status: true
    xfbml: true

window.fbLoginCallback = ->
  fbWithLogin(fbEventPublishConfirm)

window.fbLogin = ->
  FB.login(fbLoginCallback, {scope: 'manage_pages,email,create_event'})

window.fbWithLogin = (callback) ->
  console.log "[Facebook] Getting login status"
  FB.getLoginStatus (response) ->
    if response.status == 'connected'
      console.log "[Facebook] Connected and authenticated"
      uid = response.authResponse.userID
      accessToken = response.authResponse.accessToken
      callback(uid, accessToken)
    else if response.status == 'not_authorized'
      console.log "[Facebook] Not authorized. Logging in"
      fbLogin()
    else
      console.log "[Facebook] Logging in"
      fbLogin()

window.fbEventPublishConfirm = (uid, accessToken) ->
  if window.fbEventId
    console.log "[Facebook] Submitting form for event ##{ window.fbEventId }"
    $('#fb-event-form').remove()
    $('body').prepend("<form action='/admin2/shows/#{ window.fbEventId }/facebook' method='post' id='fb-event-form'><input type='hidden' name='authenticity_token' value='#{ $('meta[name="csrf-token"]').prop('content') }'></input><input type='hidden' name='uid' value='#{ uid }'></input><input type='hidden' name='access_token' value='#{ accessToken }'></input></form>")
    $('#fb-event-form').submit()
  else
    console.log "[Facebook] Event id is not set"
