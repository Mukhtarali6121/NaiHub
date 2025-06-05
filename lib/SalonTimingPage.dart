import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SalonTiming {
  final String dayName;
  bool isOpen;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  bool is24Hours;

  SalonTiming({
    required this.dayName,
    this.isOpen = true,
    this.startTime,
    this.endTime,
    this.is24Hours = false,
  });

  @override
  String toString() {
    return 'SalonTiming(day: $dayName,isOpen: $isOpen, startTime: ${_formatTime(startTime)}, endTime: ${_formatTime(endTime)}, is24Hours: $is24Hours)';
  }

  String _formatTime(TimeOfDay? time) {
    if (time == null) return 'null';
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}

class SalonTimingPage extends StatefulWidget {
  @override
  _SalonTimingPageState createState() => _SalonTimingPageState();
}

class _SalonTimingPageState extends State<SalonTimingPage> {
  final List<String> _days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  bool _sameTimingForAll = false;
  bool _open24Hours = false;
  late List<SalonTiming> _timings;

  @override
  void initState() {
    super.initState();
    _timings = List.generate(7, (index) => SalonTiming(dayName: _days[index]));
  }

  Future<void> _selectTime(
    BuildContext context,
    bool isStartTime,
    int dayIndex,
  ) async {
    final initialTime =
        isStartTime
            ? _timings[dayIndex].startTime ?? TimeOfDay(hour: 9, minute: 0)
            : _timings[dayIndex].endTime ?? TimeOfDay(hour: 17, minute: 0);

    final picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (picked != null) {
      setState(() {
        if (isStartTime) {
          _timings[dayIndex].startTime = picked;
          if (_sameTimingForAll) {
            for (int i = 0; i < 7; i++) {
              _timings[i].startTime = picked;
            }
          }
        } else {
          _timings[dayIndex].endTime = picked;
          if (_sameTimingForAll) {
            for (int i = 0; i < 7; i++) {
              _timings[i].endTime = picked;
            }
          }
        }
      });
    }
  }

  Widget _buildTimePickerButton(
    TimeOfDay? time,
    String label,
    int dayIndex,
    bool isStartTime,
  ) {
    return InkWell(
      onTap:
          _open24Hours
              ? null
              : () => _selectTime(context, isStartTime, dayIndex),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          time != null
              ? DateFormat.jm().format(
                DateTime(2023, 1, 1, time.hour, time.minute),
              )
              : label,
          style: TextStyle(color: time != null ? Colors.black : Colors.grey),
        ),
      ),
    );
  }

  Widget _buildGlobalTiming() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          if (!_open24Hours) ...[
            Row(
              children: [
                Expanded(
                  child: _buildTimePickerButton(
                    _timings[0].startTime,
                    'Start Time',
                    0,
                    true,
                  ),
                ),
                SizedBox(width: 16),
                Text('to'),
                SizedBox(width: 16),
                Expanded(
                  child: _buildTimePickerButton(
                    _timings[0].endTime,
                    'End Time',
                    0,
                    false,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
          ],
          Text(
            'This timing will apply to all 7 days',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          Divider(),
        ],
      ),
    );
  }

  Widget _buildDayRow(int index) {
    return Column(
      children: [
        ListTile(
          title: Text(_timings[index].dayName),
          trailing: Switch(
            value: _timings[index].isOpen,
            activeColor: Colors.blue,
            activeTrackColor: Color(0xFFB6DBFB),
            onChanged:
                _open24Hours
                    ? null
                    : (value) {
                      setState(() {
                        _timings[index].isOpen = value;
                        if (_sameTimingForAll) {
                          for (int i = 0; i < 7; i++) {
                            _timings[i].isOpen = value;
                          }
                        }
                      });
                    },
          ),
        ),
        if (_timings[index].isOpen && !_open24Hours)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                _buildTimePickerButton(
                  _timings[index].startTime,
                  'Start Time',
                  index,
                  true,
                ),
                SizedBox(width: 16),
                Text('to'),
                SizedBox(width: 16),
                _buildTimePickerButton(
                  _timings[index].endTime,
                  'End Time',
                  index,
                  false,
                ),
              ],
            ),
          ),
        Divider(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Salon Timings')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CheckboxListTile(
              title: Text('Open 24 Hours'),
              value: _open24Hours,
              onChanged: (value) {
                setState(() {
                  _open24Hours = value!;
                  if (_open24Hours) {
                    for (var timing in _timings) {
                      timing.isOpen = true;
                      timing.is24Hours = true;
                    }
                  }
                });
              },
            ),
            CheckboxListTile(
              title: Text(
                'Same Timing for All Days',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87, // or Colors.blueGrey for a softer look
                ),
              ),
              value: _sameTimingForAll,
              activeColor: Colors.blue,
              // Deep Blue for the checkbox
              checkColor: Colors.white,
              // Checkmark color
              onChanged:
                  _open24Hours
                      ? null
                      : (value) {
                        setState(() {
                          _sameTimingForAll = value!;
                          if (_sameTimingForAll) {
                            final firstTiming = _timings[0];
                            for (var timing in _timings) {
                              timing.startTime = firstTiming.startTime;
                              timing.endTime = firstTiming.endTime;
                              timing.isOpen = firstTiming.isOpen;
                            }
                          }
                        });
                      },
            ),
            if (_sameTimingForAll)
              _buildGlobalTiming()
            else
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 7,
                itemBuilder: (context, index) => _buildDayRow(index),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    // 🔵 Change to any color you want
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {
                    // Save logic
                    print(_timings);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Save Timings',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
