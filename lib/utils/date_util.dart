//
//
// import 'package:intl/intl.dart';
//
// String timeAgoSinceDate(DateTime dateTime, {bool numericDates = true}) {
//   final DateTime now = DateTime.now();
//   final Duration difference = now.difference(dateTime);
//
//   if (difference.inDays > 8) {
//     return DateFormat.yMMMd().format(dateTime); // Example: Sep 2, 2024
//   } else if (difference.inDays >= 1) {
//     return numericDates
//         ? '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago'
//         : '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
//   } else if (difference.inHours >= 1) {
//     return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
//   } else if (difference.inMinutes >= 1) {
//     return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
//   } else {
//     return 'Just now';
//   }
// }