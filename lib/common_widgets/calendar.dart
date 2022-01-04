import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:collection';
import 'package:intl/intl.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/util/application_colors.dart' as color;

class CustomCalendar extends StatelessWidget {
  CalendarFormat? calendarFormat;
  // DateTime? focusedDay1 = DateTime.now();
  DateTime? focusedDay1;
  DateTime? selectedDay1;
  RangeSelectionMode? rangeSelectionMode;
  DateTime? rangeStart;
  DateTime? rangeEnd;
  bool Function(dynamic) selectedDayPredict;
  void Function(DateTime, DateTime) onDaySelect;
  void Function(CalendarFormat) formatChange;
  void Function(DateTime) onPageChanged;
  void Function(DateTime?, DateTime?, DateTime) onRangeSelect;
  bool? headerDisable;
  double? dayHeight;
  bool? daysOfWeekVisible;

  CustomCalendar(
      {Key? key,
      this.calendarFormat,
      this.focusedDay1,
      this.rangeEnd,
      this.rangeSelectionMode,
      this.rangeStart,
      this.selectedDay1,
      required this.selectedDayPredict,
      required this.onDaySelect,
      required this.formatChange,
      this.headerDisable,
      required this.onRangeSelect,
      this.dayHeight,
      this.daysOfWeekVisible = false,
      required this.onPageChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 20,
      child: TableCalendar(
        // selectedDay : DateTime.now(),
        headerStyle: HeaderStyle(
            formatButtonShowsNext: false,
            formatButtonVisible: false,
            titleCentered: true,
            headerPadding: EdgeInsets.all(0.0),
            titleTextStyle: Styles.PoppinsRegular(
                fontSize: ApplicationSizing.fontScale(17)),
            leftChevronIcon: Icon(
              Icons.chevron_left_sharp,
              size: ApplicationSizing.convert(25),
            ),
            rightChevronIcon: Icon(
              Icons.chevron_right_sharp,
              size: ApplicationSizing.convert(25),
            )),
        calendarStyle: const CalendarStyle(
          isTodayHighlighted: false,
          canMarkersOverflow: false,
          outsideDaysVisible: false,
          markersAutoAligned: false,
          markerSizeScale: 0.0,
          markersAnchor: 0.0,
          rangeHighlightScale: 0.0,
          cellMargin: EdgeInsets.all(0.0),
          markerMargin: EdgeInsets.all(0.0),
          cellPadding: EdgeInsets.all(0.0),
          // rangeHighlightColor: Colors.pink,
          withinRangeDecoration: BoxDecoration(
            color: Colors.green,
            shape: BoxShape.rectangle,
          ),
          rangeEndDecoration: BoxDecoration(
            color: Colors.green,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),

              topLeft: Radius.circular(0.0),
              bottomLeft: Radius.circular(0.0),
            ),
          ),
          rangeStartDecoration: BoxDecoration(
            color: Colors.green,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0),

              topRight: Radius.circular(0.0),
              bottomRight: Radius.circular(0.0),
            ),
          ),

          // ran
        ),

        daysOfWeekVisible: daysOfWeekVisible!,
        headerVisible: headerDisable ?? true,
        daysOfWeekHeight: dayHeight ?? 1,
        rowHeight: dayHeight ?? 1,
        rangeStartDay: rangeStart ?? DateTime.now(),
        rangeEndDay: rangeEnd ?? DateTime.now(),
        firstDay: kFirstDay,
        lastDay: kLastDay,
        focusedDay: focusedDay1 ?? DateTime.now(),
        calendarFormat: calendarFormat ?? CalendarFormat.twoWeeks,
        selectedDayPredicate: selectedDayPredict,
        onDaySelected: onDaySelect,
        onFormatChanged: formatChange,
        // selectedDayPredicate: (day) {
        //   // Use `selectedDayPredicate` to determine which day is currently selected.
        //   // If this returns true, then `day` will be marked as selected.
        //
        //   // Using `isSameDay` is recommended to disregard
        //   // the time-part of compared DateTime objects.
        //   return isSameDay(selectedDay1, day);
        // },
        // onDaySelected: (selectedDay, focusedDay) {
        //   if (!isSameDay(selectedDay1, selectedDay)) {
        //     // Call `setState()` when updating the selected day
        //     setState(() {
        //       selectedDay1 = selectedDay;
        //       focusedDay1 = focusedDay;
        //     });
        //   }
        // },
        // onFormatChanged: (format) {
        //   if (_calendarFormat != format) {
        //     // Call `setState()` when updating calendar format
        //     setState(() {
        //       _calendarFormat = format;
        //     });
        //   }
        // },
        rangeSelectionMode: rangeSelectionMode ?? RangeSelectionMode.toggledOn,
        onPageChanged: onPageChanged,
        onRangeSelected: onRangeSelect,
      ),
    );
  }
}

class TableBasicsExample extends StatefulWidget {
  @override
  _TableBasicsExampleState createState() => _TableBasicsExampleState();
}

class _TableBasicsExampleState extends State<TableBasicsExample> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime focusedDay1 = DateTime.now();
  DateTime? selectedDay1;
  RangeSelectionMode? rangeSelectionMode;
  DateTime? rangeStart;
  DateTime? rangeEnd;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 20,
      child: TableCalendar(
        daysOfWeekVisible: false,
        headerVisible: true,
        daysOfWeekHeight: 1,
        rowHeight: 1,
        rangeStartDay: rangeStart,
        rangeEndDay: rangeEnd,
        firstDay: kFirstDay,
        lastDay: kLastDay,
        focusedDay: focusedDay1,
        calendarFormat: CalendarFormat.twoWeeks,
        selectedDayPredicate: (day) {
          // Use `selectedDayPredicate` to determine which day is currently selected.
          // If this returns true, then `day` will be marked as selected.

          // Using `isSameDay` is recommended to disregard
          // the time-part of compared DateTime objects.
          return isSameDay(selectedDay1, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(selectedDay1, selectedDay)) {
            // Call `setState()` when updating the selected day
            setState(() {
              selectedDay1 = selectedDay;
              focusedDay1 = focusedDay;
            });
          }
        },
        // onFormatChanged: (format) {
        //   if (_calendarFormat != format) {
        //     // Call `setState()` when updating calendar format
        //     setState(() {
        //       _calendarFormat = format;
        //     });
        //   }
        // },
        rangeSelectionMode: rangeSelectionMode ?? RangeSelectionMode.toggledOn,
        onPageChanged: (focusedDay) {
          // No need to call `setState()` here
          focusedDay1 = focusedDay;
        },
        onRangeSelected: selectRange,
      ),
    );
  }

  selectRange(start, end, focusedDay) {
    setState(() {
      selectedDay1 = null;
      focusedDay = focusedDay;
      rangeStart = start;
      rangeEnd = end;
      rangeSelectionMode = RangeSelectionMode.toggledOn;
    });
  }
}

/// Example event class.
class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
    key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
    value: (item) => List.generate(
        item % 4 + 1, (index) => Event('Event $item | ${index + 1}')))
  ..addAll({
    kToday: [
      Event('Today\'s Event 1'),
      Event('Today\'s Event 2'),
    ],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year - 1, 1, 1);
final kLastDay = DateTime(kToday.year, kToday.month, kToday.day);

class TableComplexExample extends StatefulWidget {
  @override
  _TableComplexExampleState createState() => _TableComplexExampleState();
}

class _TableComplexExampleState extends State<TableComplexExample> {
  late final PageController _pageController;
  late final ValueNotifier<List<Event>> _selectedEvents;
  final ValueNotifier<DateTime> _focusedDay = ValueNotifier(DateTime.now());
  final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();

    _selectedDays.add(_focusedDay.value);
    _selectedEvents = ValueNotifier(_getEventsForDay(_focusedDay.value));
  }

  @override
  void dispose() {
    _focusedDay.dispose();
    _selectedEvents.dispose();
    super.dispose();
  }

  bool get canClearSelection =>
      _selectedDays.isNotEmpty || _rangeStart != null || _rangeEnd != null;

  List<Event> _getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForDays(Iterable<DateTime> days) {
    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    final days = daysInRange(start, end);
    return _getEventsForDays(days);
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      if (_selectedDays.contains(selectedDay)) {
        _selectedDays.remove(selectedDay);
      } else {
        _selectedDays.add(selectedDay);
      }

      _focusedDay.value = focusedDay;
      _rangeStart = null;
      _rangeEnd = null;
      _rangeSelectionMode = RangeSelectionMode.toggledOff;
    });

    _selectedEvents.value = _getEventsForDays(_selectedDays);
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _focusedDay.value = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _selectedDays.clear();
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ValueListenableBuilder<DateTime>(
          valueListenable: _focusedDay,
          builder: (context, value, _) {
            return _CalendarHeader(
              focusedDay: value,
              clearButtonVisible: canClearSelection,
              onTodayButtonTap: () {
                setState(() => _focusedDay.value = DateTime.now());
              },
              onClearButtonTap: () {
                setState(() {
                  _rangeStart = null;
                  _rangeEnd = null;
                  _selectedDays.clear();
                  _selectedEvents.value = [];
                });
              },
              onLeftArrowTap: () {
                _pageController.previousPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              },
              onRightArrowTap: () {
                _pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              },
            );
          },
        ),
        TableCalendar<Event>(
          firstDay: kFirstDay,
          lastDay: kLastDay,
          focusedDay: _focusedDay.value,
          headerVisible: false,
          selectedDayPredicate: (day) => _selectedDays.contains(day),
          rangeStartDay: _rangeStart,
          rangeEndDay: _rangeEnd,
          calendarFormat: _calendarFormat,
          rangeSelectionMode: _rangeSelectionMode,
          eventLoader: _getEventsForDay,
          holidayPredicate: (day) {
            // Every 20th day of the month will be treated as a holiday
            return day.day == 20;
          },
          onDaySelected: _onDaySelected,
          onRangeSelected: _onRangeSelected,
          onCalendarCreated: (controller) => _pageController = controller,
          onPageChanged: (focusedDay) => _focusedDay.value = focusedDay,
          onFormatChanged: (format) {
            if (_calendarFormat != format) {
              setState(() => _calendarFormat = format);
            }
          },
        ),
        const SizedBox(height: 8.0),
        Expanded(
          child: ValueListenableBuilder<List<Event>>(
            valueListenable: _selectedEvents,
            builder: (context, value, _) {
              return ListView.builder(
                itemCount: value.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 4.0,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListTile(
                      onTap: () => print('${value[index]}'),
                      title: Text('${value[index]}'),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _CalendarHeader extends StatelessWidget {
  final DateTime focusedDay;
  final VoidCallback onLeftArrowTap;
  final VoidCallback onRightArrowTap;
  final VoidCallback onTodayButtonTap;
  final VoidCallback onClearButtonTap;
  final bool clearButtonVisible;

  const _CalendarHeader({
    Key? key,
    required this.focusedDay,
    required this.onLeftArrowTap,
    required this.onRightArrowTap,
    required this.onTodayButtonTap,
    required this.onClearButtonTap,
    required this.clearButtonVisible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headerText = DateFormat.yMMM().format(focusedDay);

    return Container(
      height: 500,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const SizedBox(width: 16.0),
          SizedBox(
            width: 120.0,
            child: Text(
              headerText,
              style: TextStyle(fontSize: 26.0),
            ),
          ),
          IconButton(
            icon: Icon(Icons.calendar_today, size: 20.0),
            visualDensity: VisualDensity.compact,
            onPressed: onTodayButtonTap,
          ),
          if (clearButtonVisible)
            IconButton(
              icon: Icon(Icons.clear, size: 20.0),
              visualDensity: VisualDensity.compact,
              onPressed: onClearButtonTap,
            ),
          const Spacer(),
          IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: onLeftArrowTap,
          ),
          IconButton(
            icon: Icon(Icons.chevron_right),
            onPressed: onRightArrowTap,
          ),
        ],
      ),
    );
  }
}
