// WorkingHoursDialog.dart
import 'package:flutter/material.dart';

enum HoursMode { allDay, same, different }

class WorkingHoursDialog extends StatefulWidget {
  final Map<String, String> initialHours;

  const WorkingHoursDialog({super.key, required this.initialHours});

  @override
  _WorkingHoursDialogState createState() => _WorkingHoursDialogState();
}

class _WorkingHoursDialogState extends State<WorkingHoursDialog> {
  late Map<String, Map<String, TimeOfDay?>> _hours;
  final List<String> _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  HoursMode _mode = HoursMode.different;
  TimeOfDay? _globalStart, _globalEnd;

  @override
  void initState() {
    super.initState();
    _hours = _parseInitialHours();
    _determineInitialMode();
  }

  Map<String, Map<String, TimeOfDay?>> _parseInitialHours() {
    final Map<String, Map<String, TimeOfDay?>> hours = {};
    for (var day in _days) {
      hours[day] = {'start': null, 'end': null};
      if (widget.initialHours.containsKey(day)) {
        final times = widget.initialHours[day]!.split(' - ');
        hours[day]!['start'] = _parseTime(times[0]);
        hours[day]!['end'] = _parseTime(times[1]);
      }
    }
    return hours;
  }

  TimeOfDay? _parseTime(String time) {
    final parts = time.split(RegExp(r'[: ]'));
    if (parts.length < 3) return null;
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    final isPM = parts[2] == 'PM';
    return TimeOfDay(hour: isPM ? hour + 12 : hour, minute: minute);
  }

  void _determineInitialMode() {
    if (_isAllDay()) {
      _mode = HoursMode.allDay;
    } else if (_isSameForAll()) {
      _mode = HoursMode.same;
      _globalStart = _hours[_days.first]!['start'];
      _globalEnd = _hours[_days.first]!['end'];
    }
  }

  bool _isAllDay() {
    return _days.every(
      (day) =>
          _hours[day]!['start'] == TimeOfDay(hour: 0, minute: 0) &&
          _hours[day]!['end'] == TimeOfDay(hour: 23, minute: 59),
    );
  }

  bool _isSameForAll() {
    final firstStart = _hours[_days.first]!['start'];
    final firstEnd = _hours[_days.first]!['end'];
    return _days.every(
      (day) =>
          _hours[day]!['start'] == firstStart &&
          _hours[day]!['end'] == firstEnd,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Set Working Hours'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            _buildModeSelector(),
            if (_mode == HoursMode.same) _buildGlobalTimePicker(),
            if (_mode == HoursMode.different)
              ..._days.map((day) => _buildDayRow(day)).toList(),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(onPressed: _saveHours, child: const Text('Save')),
      ],
    );
  }

  Widget _buildModeSelector() {
    return Column(
      children: [
        RadioListTile<HoursMode>(
          title: const Text('24/7 Availability'),
          value: HoursMode.allDay,
          groupValue: _mode,
          onChanged: _handleModeChange,
        ),
        RadioListTile<HoursMode>(
          title: const Text('Same hours for all days'),
          value: HoursMode.same,
          groupValue: _mode,
          onChanged: _handleModeChange,
        ),
        RadioListTile<HoursMode>(
          title: const Text('Different hours per day'),
          value: HoursMode.different,
          groupValue: _mode,
          onChanged: _handleModeChange,
        ),
      ],
    );
  }

  void _handleModeChange(HoursMode? value) {
    if (value == null) return;
    setState(() {
      _mode = value;
      if (value == HoursMode.allDay) {
        _setAllDayHours();
      } else if (value == HoursMode.same) {
        _globalStart = _hours[_days.first]!['start'];
        _globalEnd = _hours[_days.first]!['end'];
      }
    });
  }

  Widget _buildGlobalTimePicker() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: _TimePickerButton(
              time: _globalStart,
              onPressed: () => _pickTime(isStart: true),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text('-'),
          ),
          Expanded(
            child: _TimePickerButton(
              time: _globalEnd,
              onPressed: () => _pickTime(isStart: false),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickTime({required bool isStart}) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: (isStart ? _globalStart : _globalEnd) ?? TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          _globalStart = picked;
        } else {
          _globalEnd = picked;
        }
        if (_mode == HoursMode.same) {
          for (var day in _days) {
            _hours[day]!['start'] = _globalStart;
            _hours[day]!['end'] = _globalEnd;
          }
        }
      });
    }
  }

  Widget _buildDayRow(String day) {
    final startTime = _hours[day]!['start'];
    final endTime = _hours[day]!['end'];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              day,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: _TimePickerButton(
              time: startTime,
              onPressed: () => _selectTime(day, true),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Text('-'),
          ),
          Expanded(
            flex: 3,
            child: _TimePickerButton(
              time: endTime,
              onPressed: () => _selectTime(day, false),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectTime(String day, bool isStart) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _hours[day]![isStart ? 'start' : 'end'] ?? TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() => _hours[day]![isStart ? 'start' : 'end'] = picked);
    }
  }

  void _setAllDayHours() {
    const fullDayStart = TimeOfDay(hour: 0, minute: 0);
    const fullDayEnd = TimeOfDay(hour: 23, minute: 59);
    for (var day in _days) {
      _hours[day]!['start'] = fullDayStart;
      _hours[day]!['end'] = fullDayEnd;
    }
  }

  void _saveHours() {
    final formattedHours = <String, String>{};

    for (var day in _days) {
      final start = _hours[day]!['start'];
      final end = _hours[day]!['end'];

      if (start != null && end != null) {
        if (end.hour < start.hour ||
            (end.hour == start.hour && end.minute < start.minute)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('End time cannot be before start time for $day'),
            ),
          );
          return;
        }

        formattedHours[day] = '${_formatTime(start)} - ${_formatTime(end)}';
      }
    }

    Navigator.pop(context, formattedHours);
  }

  String _formatTime(TimeOfDay time) {
    return MaterialLocalizations.of(context).formatTimeOfDay(time);
  }
}

class _TimePickerButton extends StatelessWidget {
  final TimeOfDay? time;
  final VoidCallback onPressed;

  const _TimePickerButton({required this.time, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.black,
      ),
      onPressed: onPressed,
      child: Text(
        time != null
            ? MaterialLocalizations.of(context).formatTimeOfDay(time!)
            : 'Select Time',
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}
