import 'package:intl/intl.dart';

String toShortDate(int dateTime) => DateFormat(
  'dd MMM, y',
).format(DateTime.fromMicrosecondsSinceEpoch(dateTime));

String toLongtDate(int dateTime) => DateFormat(
  'dd MMMM y, hh:mm a',
).format(DateTime.fromMicrosecondsSinceEpoch(dateTime));
