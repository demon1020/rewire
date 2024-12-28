import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class AppCalendar extends StatelessWidget {
  final DateTime firstDay;
  final DateTime lastDay;
  final DateTime focusedDay;
  final DateTime selectedDay;
  final Function(DateTime, DateTime) onDaySelected;
  final Function(CalendarFormat) onFormatChanged;
  final Map<DateTime, List<String>> events;
  final CalendarFormat calendarFormat;

  AppCalendar({
    required this.firstDay,
    required this.lastDay,
    required this.focusedDay,
    required this.selectedDay,
    required this.onDaySelected,
    required this.onFormatChanged,
    required this.events,
    required this.calendarFormat,
  });

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: firstDay,
      lastDay: lastDay,
      focusedDay: focusedDay,
      selectedDayPredicate: (day) => isSameDay(selectedDay, day),
      onDaySelected: onDaySelected,
      eventLoader: (day) {
        DateTime dateOnly = DateTime(day.year, day.month, day.day);
        return events[dateOnly] ?? [];
      },
      calendarFormat: calendarFormat,
      headerStyle: HeaderStyle(
        formatButtonVisible: true,
        formatButtonTextStyle: TextStyle(color: Colors.white),
        formatButtonDecoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(5.0),
        ),
        leftChevronIcon: Icon(Icons.arrow_back),
        rightChevronIcon: Icon(Icons.arrow_forward),
      ),
      onFormatChanged: onFormatChanged,
    );
  }
}
