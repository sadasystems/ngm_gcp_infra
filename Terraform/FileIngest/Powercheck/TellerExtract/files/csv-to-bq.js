function transform(line) {
  var values = line.split('|');

  var obj = new Object();
  obj.TellerRefNo = values[0];
  obj.FirstName = values[1];
  obj.LastName = values[2];
  obj.UserName = values[3];
  obj.LastLoginDate = values[4];
  var jsonString = JSON.stringify(obj);
  return jsonString;
}