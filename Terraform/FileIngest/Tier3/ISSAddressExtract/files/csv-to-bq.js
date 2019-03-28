function transform(line) {
  var values = line.split('|');

  var obj = new Object();
  obj.IssuerRefNo = values[0];
  obj.AddressType = values[1];
  obj.Address = values[2];
  obj.City = values[3];
  obj.State = values[4];
  obj.ZipCode = values[5];
  var jsonString = JSON.stringify(obj);
  return jsonString;
}