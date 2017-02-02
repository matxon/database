var formData = new FormData( document.forms.userlogin );

console.log(formData);

var xhr = new XMLHttpRequest();

xhr.open('POST', '/login');
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
  console.log(JSON.parse(this.responseText));
}

/*
var xhr = new XMLHttpRequest();

xhr.open("GET", "/users", true);
xhr.send();

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
  console.log(JSON.parse(this.responseText));
}
*/
