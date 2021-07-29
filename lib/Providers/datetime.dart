import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Day of week enumeration.
enum DOW {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}

/// Month enumeration.
enum Month {
  january,
  february,
  march,
  april,
  may,
  june,
  july,
  august,
  september,
  october,
  november,
  december,
}
const String kDateFormat = 'MMM d, y';

const String kDateTimeFormat = 'MMM d, y HH:mm';
const String kTimeFormat = 'HH:mm';
/// [DateTieme] extensions.
extension DateTimeExtension on DateTime {
  String get toLocalDateString {
    return DateFormat(kDateFormat).format(this);
  }

  String get toLocalTimeString {
    return DateFormat(kTimeFormat).format(this);
  }

  String get toLocalDateTimeString {
    return DateFormat(kDateTimeFormat).format(this);
  }


}
