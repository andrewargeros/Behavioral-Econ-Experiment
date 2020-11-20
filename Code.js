function doGet(e) 
{
  var even = HtmlService.createTemplateFromFile("even_user"); // Create HTML Form for Even Users
  var odd = HtmlService.createTemplateFromFile("odd_user");
  var today = new Date();
  var dt = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate(); // Date 
  
  // Get Data from Sheets 
  var wb = SpreadsheetApp.getActive();
  var sheet = wb.getSheetByName("Form Responses 1");
  var data = sheet.getDataRange().getValues();
  var headers = data.shift();
  
  // Allow for Proxy Backdoor for Checks
  var proxy = e.parameter.email;
  if (proxy) {
    var user = proxy;
  } else {
    var user = Session.getActiveUser().getEmail();
  };
  
  var tprox = e.parameter.type
  
  if (data.length % 2 == 0 || tprox) {
  return odd.evaluate();
  } else {
  return even.evaluate();
  }
}

function getRandomInt(min, max) 
{
  var min = Math.ceil(min);
  var max = Math.floor(max);
  var final = Math.floor(Math.random() * (max - min + 1) + min);
  return final
}