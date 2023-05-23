import 'package:flutter/material.dart';

class MyScreen extends StatefulWidget {
  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  String currentTime = '';
  String currentDay = '';
  String currentDate = '';

  @override
  void initState() {
    super.initState();
    // Call the function to update the time, day, and date
    _updateDateTime();
  }

  void _updateDateTime() {
    // Get the current DateTime
    DateTime now = DateTime.now();

    // Format the time
    String formattedTime = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';

    // Format the day
    String formattedDay = _getFormattedDay(now.weekday);

    // Format the date
    String formattedDate = '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}';

    // Update the state variables
    setState(() {
      currentTime = formattedTime;
      currentDay = formattedDay;
      currentDate = formattedDate;
    });
  }

  String _getFormattedDay(int weekday) {
    // Create a list of weekday names
    List<String> days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

    // Get the corresponding weekday name based on the weekday index (1-7)
    return days[weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Current Date and Time'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Current Time: $currentTime',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Current Day: $currentDay',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Current Date: $currentDate',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
