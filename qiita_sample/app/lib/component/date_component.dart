import 'package:intl/intl.dart';

class DateComponent {
  String setUpDataFormat(DateTime date) {
    DateFormat outputformat = DateFormat('M/d H:mm');
    return outputformat.format(date);
  }
}
