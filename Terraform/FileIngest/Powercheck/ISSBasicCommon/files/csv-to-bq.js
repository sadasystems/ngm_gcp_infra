function transform(line) {
  var values = line.split('|');

  var obj = new Object();
  obj.IssuerRefNo = values[0];
  obj.IssuerName = values[1];
  obj.IssuerType = values[2];
  var jsonString = JSON.stringify(obj);
  return jsonString;
}