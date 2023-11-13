
String errorMessage(List<dynamic>? errors) {
  String msg = "";

  if (errors is List) {
    for (int i = 0; i < errors.length; i++) {
      msg += "${errors[i]}\n";
    }
  } else {
    msg = errors.toString();
  }
  return msg;
}