function transform(line) {
  var values = line.split('|');

  var obj = new Object();
  obj.CustomerRefNumber = values[0];
  obj.FirstName = values[1];
  obj.MiddleName = values[2];
  obj.LastName = values[3];
  obj.SecondLastName = values[4];
  obj.DOB = values[5];
  var jsonString = JSON.stringify(obj);
  return jsonString;
}