import 'package:intl/intl.dart';

List<DateTime> sortDateTime(List<String> list) {
  /*
  [list] will contain strings representing date/time. These are formatted as shown:
  YYYY-MM-DD (eg. 2022-01-21)
   */

  List<DateTime> newList = [];
  DateFormat format = DateFormat("yyyy-MM-dd");

  for (int i = 0; i < 5; i++) {
    newList.add(format.parse(list[i]));
  }
  newList.sort((a, b) => a.compareTo(b));

  return newList;
}