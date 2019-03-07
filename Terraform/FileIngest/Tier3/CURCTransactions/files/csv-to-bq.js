function transform(line) {
  var values = line.split('|');

  var obj = new Object();
  obj.TransactionRefNo = values[0];
  obj.StoreRefNo = values[1];
  obj.Date = values[2];
  obj.Time = values[3];
  obj.CustomerRefNumber = values[4];
  obj.TellerRefNo = values[5];
  obj.Amount = values[6];
  obj.Fee = values[7];
  obj.Net = values[8];
  obj.Product = values[9];
  obj.CurrencyType = values[10];
  obj.OperationType = values[11];
  var jsonString = JSON.stringify(obj);
  return jsonString;
}