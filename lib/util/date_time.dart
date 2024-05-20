import 'package:intl/intl.dart';


/// This function parses a dateTime string into a DateTime object and returns the date part. For example, if the dateTimeString is "2023-12-02T00:56:51.997885Z", the function returns "02/12/2023".
String parseDate (String dateTimeString) {

  // Parse the date string
  DateTime dateTime = DateTime.parse(dateTimeString);


  // Extract the date part
  String formattedDate = "${dateTime.day}/${dateTime.month}/${dateTime.year}";

  // Return the formatted date and time
  return formattedDate;

} 

/// This function parses a dateTime string into a DateTime object and returns the time part. For example, if the dateTimeString is "2023-12-02T00:56:51.997885Z", the function returns "00:56".
String parseTime (String dateTimeString) {

  // Parse the date string
  DateTime dateTime = DateTime.parse(dateTimeString);

  // Extract the time part
  String formattedTime = "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";

  return formattedTime;

}



/// This function parses a dateTime string into a DateTime object and returns the date in words. For example, if the dateTimeString is "2023-12-02T00:56:51.997885Z", the function returns "2 December".
String formatDateIntoWords(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);

  String day = DateFormat.d().format(dateTime); // Day of the month
  String month = DateFormat.MMMM().format(dateTime); // Month
  String weekday = DateFormat.EEEE().format(dateTime); // Full day of the week

  return "${weekday.substring(0, 3)} $day ${month.substring(0, 3)} ${dateTime.year}" ;
}


/// This function takes a time string in the format "hh:mm:ss" and returns the time in the format "hh:mm". For example, if the timeString is "00:56:51", the function returns "00:56".
String formatTime(String timeString) {

  return timeString.substring(0, 5);
  
}


/// This function takes a month string in the format "yyyy-mm" and returns the month in the format "MMMM y". For example, if the month is "2023-12", the function returns "December 2023".
String formatMonth(String month) {
  DateTime dateTime = DateTime.parse('$month-01');
  return DateFormat('MMMM y').format(dateTime);
}


