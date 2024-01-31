import 'package:equatable/equatable.dart';

class DateAndTime extends Equatable {
  final String date;
  final String time;

  const DateAndTime({
    required this.date,
    required this.time,
  });
  Map<String, dynamic> toMap() {
    return {
      'Date': date,
      'Time': time,
    };
  }

  factory DateAndTime.fromMap(Map<String, dynamic> data) {
    return DateAndTime(
      date: data['Date'],
      time: data['Time'],
    );
  }

//  create new instance of date and time and format them
  static DateAndTime newDate() {
    DateTime now = DateTime.now();
    return DateAndTime(
      date:
          "${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}",
      time:
          "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}",
    );
  }

  @override
  List<Object?> get props => [date, time];
}
