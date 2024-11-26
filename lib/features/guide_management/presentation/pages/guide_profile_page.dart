// presentation/pages/guide_profile_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/guide.dart';
import '../viewmodels/guide_viewmodel.dart';
class GuideProfilePage extends StatefulWidget {
  const GuideProfilePage({super.key, required String guideId});

  @override
  State<GuideProfilePage> createState() => _GuideProfilePageState();
}

class _GuideProfilePageState extends State<GuideProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _countryController = TextEditingController();
  final _introductionController = TextEditingController();

  Map<String, double> fees = {
    '1-3': 0.0,
    '4-6': 0.0,
    '7-9': 0.0,
    '10-14': 0.0,
  };

  Map<String, List<TimeSlot>> availability = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complete Your Profile'),
        backgroundColor: Colors.teal,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            Text(
              'Background Information',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _firstNameController,
              decoration: InputDecoration(
                labelText: 'First Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter your first name';
                }
                return null;
              },
            ),
            // Add other form fields similar to the UI shown in images
            // ...

            ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1DE9B6),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text('FINISH'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<GuideViewModel>().registerGuide(
            firstName: _firstNameController.text,
            lastName: _lastNameController.text,
            email: _emailController.text,
            phoneNumber: _phoneController.text,
            address: _addressController.text,
            city: _cityController.text,
            country: _countryController.text,
            guideLicenseUrl: '', // Add proper file upload handling
            identityCardUrl: '', // Add proper file upload handling
            languages: [], // Add language selection handling
            introduction: _introductionController.text,
            fees: fees,
            availability: availability,
          );
    }
  }
}
