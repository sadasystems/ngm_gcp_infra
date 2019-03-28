function transform(line) {
  var values = line.split('|');

  var obj = new Object();
  obj.CustomerRefNumber = values[0];
  obj.IdentificationType = values[1];
  obj.IdentificationNumber = values[2];
  obj.ExpirationDate = values[3];
  var jsonString = JSON.stringify(obj);
  return jsonString;
}