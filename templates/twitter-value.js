const screenName = document.getElementById('screen_name').getAttribute('content');
app.ports.jsGetTwitterValue.send(screenName);
