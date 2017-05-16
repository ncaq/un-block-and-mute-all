const oauthToken = document.getElementById('oauth_token').getAttribute('content');
const screenName = document.getElementById('screen_name').getAttribute('content');
app.ports.jsGetTwitterValue.send({oauthToken: oauthToken, screenName: screenName});
