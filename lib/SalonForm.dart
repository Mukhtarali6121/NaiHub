import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LocationFormPage.dart';

class SalonForm extends StatefulWidget {
  @override
  _SalonFormState createState() => _SalonFormState();
}

class _SalonFormState extends State<SalonForm> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _socialMedia = {'facebook': '', 'instagram': ''};

  // Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _logoController = TextEditingController();
  final TextEditingController _facebookController = TextEditingController();
  final TextEditingController _instagramController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Salon Registration')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(
                controller: _nameController,
                keyboardType: TextInputType.name,
                label: 'Salon Name',
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: 16),
              _buildTextField(
                controller: _addressController,
                label: 'Address',
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: 16),
              _buildTextField(
                controller: _phoneController,
                label: 'Contact Phone',
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator:
                    (value) =>
                        value!.length < 10 ? 'Invalid phone number' : null,
              ),
              SizedBox(height: 16),
              _buildTextField(
                controller: _emailController,
                label: 'Contact Email',
                keyboardType: TextInputType.emailAddress,
                validator:
                    (value) => !value!.contains('@') ? 'Invalid email' : null,
              ),
              SizedBox(height: 16),
              _buildTextField(
                controller: _websiteController,
                label: 'Website',
                keyboardType: TextInputType.url,
                validator:
                    (value) =>
                        !value!.startsWith('http') ? 'Invalid URL' : null,
              ),
              SizedBox(height: 16),
              _buildTextField(
                controller: _descriptionController,
                label: 'Description',
                maxLines: 3,
                validator:
                    (value) =>
                        value!.length < 50 ? 'Minimum 50 characters' : null,
              ),
              SizedBox(height: 16),
              _buildTextField(
                controller: _logoController,
                label: 'Logo URL',
                keyboardType: TextInputType.url,
                validator:
                    (value) =>
                        !value!.startsWith('http') ? 'Invalid URL' : null,
              ),
              SizedBox(height: 24),
              Text(
                'Social Media Links',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              _buildTextField(
                controller: _facebookController,
                label: 'Facebook URL',
                keyboardType: TextInputType.url,
                prefixText: 'facebook.com/',
              ),
              SizedBox(height: 16),
              _buildTextField(
                controller: _instagramController,
                label: 'Instagram URL',
                keyboardType: TextInputType.url,
                prefixText: 'instagram.com/',
              ),
              SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Submit'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? prefixText,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        prefixText: prefixText,
      ),
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      validator: validator,
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final salonData = {
        'salon_name': _nameController.text,
        'address': _addressController.text,
        'contact_phone': _phoneController.text,
        'contact_email': _emailController.text,
        'website': _websiteController.text,
        'description': _descriptionController.text,
        'logo_url': _logoController.text,
        'social_media_links': {
          'facebook': _facebookController.text,
          'instagram': _instagramController.text,
        },
      };

      // Navigate to LocationFormPage with salonData
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LocationFormPage(salonData: salonData),
        ),
      );
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Success'),
            content: Text('Salon information submitted successfully'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _websiteController.dispose();
    _descriptionController.dispose();
    _logoController.dispose();
    _facebookController.dispose();
    _instagramController.dispose();
    super.dispose();
  }

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('userData');

    if (jsonString != null) {
      final data = jsonDecode(jsonString);
      print("Loaded user data: $data");
      // You can cast to List<Map<String, dynamic>> if needed
    } else {
      print("No user data found.");
    }
  }

  @override
  void initState() {
    super.initState();
    loadUserData();
  }
}
