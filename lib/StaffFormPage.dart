// main.dart
import 'package:flutter/material.dart';

import 'WorkingHoursDialog.dart';

class StaffFormPage extends StatefulWidget {
  final Map<String, dynamic> salonData;
  final Map<String, dynamic> locationData;

  const StaffFormPage({
    super.key,
    required this.salonData,
    required this.locationData,
  });

  @override
  _StaffFormPageState createState() => _StaffFormPageState();
}

class _StaffFormPageState extends State<StaffFormPage> {
  final _formKey = GlobalKey<FormState>();
  final List<Map<String, dynamic>> _staffMembers = [];
  final Map<String, String> _workingHours = {};

  // Controllers
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _photoController = TextEditingController();

  String? _selectedRole;
  String? _selectedSpecialization;
  bool _isActive = true;

  final List<String> _roles = ['Stylist', 'Receptionist', 'Manager'];
  final List<String> _specializations = [
    'Hair Coloring',
    'Spa',
    'Haircut',
    'Massage',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Staff Information'),
        actions: [
          IconButton(icon: const Icon(Icons.save), onPressed: _saveStaffMember),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildNameFields(),
                      // const SizedBox(height: 16),
                      // _buildRoleDropdown(),
                      // const SizedBox(height: 16),
                      // _buildSpecializationDropdown(),
                      const SizedBox(height: 16),
                      _buildWorkingHoursSelector(),
                      const SizedBox(height: 16),
                      _buildContactFields(),
                      const SizedBox(height: 16),
                      _buildPhotoUrlField(),
                      const SizedBox(height: 16),
                      SwitchListTile(
                        title: const Text('Active Status'),
                        value: _isActive,
                        onChanged: (value) => setState(() => _isActive = value),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Divider(),
            const Text('Added Staff Members', style: TextStyle(fontSize: 18)),
            Expanded(
              child: ListView.builder(
                itemCount: _staffMembers.length,
                itemBuilder: (context, index) {
                  final staff = _staffMembers[index];
                  return ListTile(
                    title: Text(
                      '${staff['first_name'] ?? 'N/A'} ${staff['last_name'] ?? ''}',
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(staff['role']?.toString() ?? 'No role specified'),
                        if (staff['working_hours'] != null &&
                            staff['working_hours'].isNotEmpty)
                          Text(
                            _getHoursSummary(staff['working_hours']),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                      ],
                    ),
                    trailing: Icon(
                      staff['is_active'] as bool? ?? false
                          ? Icons.check_circle
                          : Icons.remove_circle,
                      color:
                          (staff['is_active'] as bool? ?? false)
                              ? Colors.green
                              : Colors.red,
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _submitAllData,
              child: const Text('Submit All Data'),
            ),
          ],
        ),
      ),
    );
  }

  String _getHoursSummary(Map<String, String> hours) {
    if (hours.isEmpty) return 'No hours set';

    // Check if all days have same hours
    final allValues = hours.values.toSet();
    if (allValues.length == 1) {
      return 'Daily: ${allValues.first}';
    }

    // Check for weekday/weekend pattern
    final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
    final weekdayHours =
        hours.entries
            .where((e) => weekdays.contains(e.key))
            .map((e) => e.value)
            .toSet();

    final weekendHours =
        hours.entries
            .where((e) => !weekdays.contains(e.key))
            .map((e) => e.value)
            .toSet();

    if (weekdayHours.length == 1 && weekendHours.length == 1) {
      return 'Weekdays: ${weekdayHours.first}\nWeekends: ${weekendHours.first}';
    }

    // Return first 2 entries if nothing matches
    return hours.entries.map((e) => '${e.key}: ${e.value}').join('\n');
  }

  Widget _buildNameFields() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _firstNameController,
            decoration: const InputDecoration(
              labelText: 'First Name',
              border: OutlineInputBorder(),
            ),
            validator: (value) => value!.isEmpty ? 'Required' : null,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextFormField(
            controller: _lastNameController,
            decoration: const InputDecoration(
              labelText: 'Last Name',
              border: OutlineInputBorder(),
            ),
            validator: (value) => value!.isEmpty ? 'Required' : null,
          ),
        ),
      ],
    );
  }

  Widget _buildRoleDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedRole,
      decoration: const InputDecoration(
        labelText: 'Role',
        border: OutlineInputBorder(),
      ),
      items:
          _roles
              .map((role) => DropdownMenuItem(value: role, child: Text(role)))
              .toList(),
      onChanged: (value) => setState(() => _selectedRole = value),
      validator: (value) => value == null ? 'Please select a role' : null,
    );
  }

  Widget _buildSpecializationDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedSpecialization,
      decoration: const InputDecoration(
        labelText: 'Specialization',
        border: OutlineInputBorder(),
      ),
      items:
          _specializations
              .map((spec) => DropdownMenuItem(value: spec, child: Text(spec)))
              .toList(),
      onChanged: (value) => setState(() => _selectedSpecialization = value),
      validator:
          (value) => value == null ? 'Please select a specialization' : null,
    );
  }

  Widget _buildWorkingHoursSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Working Hours', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),

            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                final result = await showDialog<Map<String, String>>(
                  context: context,
                  builder:
                      (context) =>
                          WorkingHoursDialog(initialHours: _workingHours),
                );
                if (result != null) {
                  setState(
                    () =>
                        _workingHours
                          ..clear()
                          ..addAll(result),
                  );
                }
              },
            ),
          ],
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ..._workingHours.entries.map(
              (e) => Chip(
                label: Text('${e.key}: ${e.value}'),
                onDeleted: () => setState(() => _workingHours.remove(e.key)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContactFields() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) => value!.contains('@') ? null : 'Invalid email',
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextFormField(
            controller: _phoneController,
            decoration: const InputDecoration(
              labelText: 'Phone',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.phone,
            validator:
                (value) =>
                    value != null && value.trim().length >= 10
                        ? null
                        : 'Invalid phone number',
          ),
        ),
      ],
    );
  }

  Widget _buildPhotoUrlField() {
    return TextFormField(
      controller: _photoController,
      decoration: const InputDecoration(
        labelText: 'Profile Photo URL',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.url,
      validator: (value) => value!.startsWith('http') ? null : 'Invalid URL',
    );
  }

  void _saveStaffMember() {
    if (_formKey.currentState!.validate()) {
      final staffData = {
        'first_name': _firstNameController.text,
        'last_name': _lastNameController.text,
        'role': _selectedRole,
        'specialization': _selectedSpecialization,
        'working_hours': {..._workingHours},
        'email': _emailController.text,
        'phone': _phoneController.text,
        'profile_photo_url': _photoController.text,
        'is_active': _isActive,
      };

      setState(() {
        _staffMembers.add(staffData);
        _clearForm();
      });
    }
  }

  void _clearForm() {
    _firstNameController.clear();
    _lastNameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _photoController.clear();
    _workingHours.clear();
    setState(() {
      _selectedRole = null;
      _selectedSpecialization = null;
      _isActive = true;
    });
  }

  void _submitAllData() {
    final completeData = {
      ...widget.salonData,
      ...widget.locationData,
      'staff_members': _staffMembers,
    };
    print(completeData);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _photoController.dispose();
    super.dispose();
  }
}
