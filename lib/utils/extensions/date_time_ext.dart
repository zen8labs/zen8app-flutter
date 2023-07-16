import 'package:intl/intl.dart';
import '../helpers/extendable.dart';

extension DateTimeExtendable on Extendable<DateTime> {
  String asString(String pattern) {
    return DateFormat(pattern).format(base);
  }
}
