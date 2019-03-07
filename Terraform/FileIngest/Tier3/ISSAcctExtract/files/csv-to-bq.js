function transform(line) {
  var values = line.split('|');

  var obj = new Object();
  obj.IssuerRefNo = values[0];
  obj.RoutingNumber = values[1];
  obj.AccountNumber = values[2];
  var jsonString = JSON.stringify(obj);
  return jsonString;
}