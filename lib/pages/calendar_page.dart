import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../widgets/app_calender.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  final DateTime _firstDay = DateTime.utc(2020, 01, 01);
  final DateTime _lastDay = DateTime.utc(2050, 12, 31);

  final Map<DateTime, List<String>> _events = {
    DateTime(2024, 12, 25): ['Christmas Day'],
    DateTime(2024, 12, 31): ['New Year\'s Eve'],
  };

  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            AppCalendar(
              firstDay: _firstDay,
              lastDay: _lastDay,
              focusedDay: _focusedDay,
              selectedDay: _selectedDay,
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              events: _events,
              calendarFormat: _calendarFormat,
            ),
            Expanded(
              child: ListView(
                children: _events[DateTime(_selectedDay.year,
                            _selectedDay.month, _selectedDay.day)]
                        ?.map((event) => ListTile(
                              title: Text(event),
                            ))
                        .toList() ??
                    [],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
