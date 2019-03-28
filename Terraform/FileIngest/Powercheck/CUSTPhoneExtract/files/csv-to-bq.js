function transform(line) {
  var values = line.split('|');

  var obj = new Object();
  obj.CustomerRefNumber = values[0];
  obj.PhoneType = values[1];
  obj.PhoneNumber = values[2];
  var jsonString = JSON.stringify(obj);
  return jsonString;
}