import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:simple_calendar_events/models/event.dart';
import 'package:simple_calendar_events/screens/event_list_screen.dart';
import 'package:simple_calendar_events/services/event_service.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final eventService = Provider.of<EventService>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Calendar')), 
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  DateFormat('MMMM yyyy').format(_selectedDate),
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: const Text('Select Date'),
                ),
              ],
            ),
          ),
          Expanded(
            child: EventListScreen(selectedDate: _selectedDate),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Show dialog to add event
          String? eventTitle = await showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              String newEventTitle = '';
              return AlertDialog(
                title: const Text('Add Event'),
                content: TextField(
                  onChanged: (value) {
                    newEventTitle = value;
                  },
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text('Add'),
                    onPressed: () {
                      Navigator.of(context).pop(newEventTitle);
                    },
                  ),
                ],
              );
            },
          );
          if (eventTitle != null && eventTitle.isNotEmpty) {
            final newEvent = Event(
              title: eventTitle,
              date: _selectedDate,
            );
            await eventService.addEvent(newEvent);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}