import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MyCalendar extends StatefulWidget {
  const MyCalendar({super.key});

  @override
  State<MyCalendar> createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> {
  var _selectedDay, _focusedDay;
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
        rowHeight: 40,
        firstDay: DateTime.utc(2024, 11, 1),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: DateTime.now(),
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay; // update `_focusedDay` here as well
          });
        },
        headerStyle: HeaderStyle(formatButtonVisible: false),
        calendarBuilders: CalendarBuilders(
          dowBuilder: (context, day) {
            switch (day.weekday) {
              case 1:
                return Center(
                  child: Text('월'),
                );
              case 2:
                return Center(
                  child: Text('화'),
                );
              case 3:
                return Center(
                  child: Text('수'),
                );
              case 4:
                return Center(
                  child: Text('목'),
                );
              case 5:
                return Center(
                  child: Text('금'),
                );
              case 6:
                return Center(
                  child: Text('토'),
                );
              case 7:
                return Center(
                  child: Text(
                    '일',
                    style: TextStyle(color: Colors.red),
                  ),
                );
            }
          },
        ));
  }
}
