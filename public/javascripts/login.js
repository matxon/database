$('#btnsend').click(function() {
  var formData = new FormData(document.forms.userlogin);

  formData.append("mail", "kmadi@inbox.ru");

  /*
  for (var value of formData.values()) {
    console.log(value); 
  }
  */

  var xhr = new XMLHttpRequest();

  xhr.open("POST", "/login");
  xhr.send(formData);

  xhr.onreadystatechange = function() {
    if (this.readyState != 4) return;

    // по окончании запроса доступны:
    // status, statusText
    // responseText, responseXML (при content-type: text/xml)
    //

    if (this.status != 200) {
      alert('ошибка: ' + (this.status ? this.statusText : 'запрос не удался'));
      return;
    }

    // получить результат из this.responseText или this.responseXML
    //alert(this.responseText);
    response = JSON.parse(this.responseText);
    //console.log(JSON.parse(response));
    if (response.ok) {
      console.log(response.ok);
    } else {
      $('.form-signin:first').effect('shake', { persent: 50 }, 500 );
    }
  }
});
