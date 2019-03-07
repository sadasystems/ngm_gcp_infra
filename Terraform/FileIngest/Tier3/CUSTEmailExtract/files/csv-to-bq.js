function transform(line) {
  var values = line.split('|');

  var obj = new Object();
  obj.CustomerRefNumber = values[0];
  obj.Email = values[1];
  var jsonString = JSON.stringify(obj);
  return jsonString;
}