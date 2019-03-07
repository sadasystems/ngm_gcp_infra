function transform(line) {
  var values = line.split('|');

  var obj = new Object();
  obj.CustomerRefNumber = values[0];
  obj.FirstName = values[1];
  obj.MiddleName = values[2];
  obj.LastName = values[3];
  obj.SecondLastName = values[4];
  obj.DayOfBirth = values[5];
  obj.MonthOfBirth = values[6];
  obj.YearOfBirth = values[7];
  var jsonString = JSON.stringify(obj);
  return jsonString;
}