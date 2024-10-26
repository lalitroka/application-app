import 'package:firstdemo/bloc/profile_bloc.dart';
import 'package:firstdemo/bloc/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  final String? employeeId;

  const ProfilePage({super.key, this.employeeId});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>(); // Form key for validation

  DateTime? _selectDOB;
  DateTime? _selectAppointment;
  File? _image;
  bool isEditMode = false;
  bool _isProfileLoaded = false;

  late TextEditingController nameController;
  late TextEditingController positionController;
  late TextEditingController employeeIdController;
  late TextEditingController contactNoController;
  late TextEditingController emergencyContactController;
  late TextEditingController appointedDateController;
  late TextEditingController bloodTypeController;
  late TextEditingController dobController;
  late TextEditingController panNoController;

  final textOnlyFormatter = [
    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
  ];

  final phoneNumberFormatter = [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(10),
  ];

  final panNumberFormatter = [
    FilteringTextInputFormatter.allow(RegExp(r'[A-Z0-9]')),
    LengthLimitingTextInputFormatter(10),
  ];

  final bloodTypeFormatter = [
    FilteringTextInputFormatter.allow(RegExp(r'[ABOab+−-]')),
    LengthLimitingTextInputFormatter(3),
  ];

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    positionController = TextEditingController();
    employeeIdController = TextEditingController();
    contactNoController = TextEditingController();
    emergencyContactController = TextEditingController();
    bloodTypeController = TextEditingController();
    panNoController = TextEditingController();
    dobController = TextEditingController();
    appointedDateController = TextEditingController();
    _loadProfile();

    if (widget.employeeId != null) {
      context.read<ProfileBloc>().add(LoadProfileEvent(widget.employeeId!));
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    positionController.dispose();
    employeeIdController.dispose();
    contactNoController.dispose();
    emergencyContactController.dispose();
    bloodTypeController.dispose();
    panNoController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      _saveProfile();
    }
  }

  Future<void> _saveProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('name', nameController.text);
    await prefs.setString('position', positionController.text);
    await prefs.setString('employeeId', employeeIdController.text);
    await prefs.setString('contactNo', contactNoController.text);
    await prefs.setString('emergencyContact', emergencyContactController.text);
    await prefs.setString('dob', dobController.text);
    await prefs.setString('bloodType', bloodTypeController.text);
    await prefs.setString('appointedDate', appointedDateController.text);
    await prefs.setString('panNo', panNoController.text);

    if (_image != null) {
      await prefs.setString('profilePhoto', _image!.path);
    }
  }

  void _loadProfile() async {
    if (_isProfileLoaded) return;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      nameController.text = prefs.getString('name') ?? '';
      positionController.text = prefs.getString('position') ?? '';
      employeeIdController.text = prefs.getString('employeeId') ?? '';
      contactNoController.text = prefs.getString('contactNo') ?? '';
      emergencyContactController.text =
          prefs.getString('emergencyContact') ?? '';
      dobController.text = prefs.getString('dob') ?? '';
      bloodTypeController.text = prefs.getString('bloodType') ?? '';
      appointedDateController.text = prefs.getString('appointedDate') ?? '';
      panNoController.text = prefs.getString('panNo') ?? '';

      String? imagePath = prefs.getString('profilePhoto');
      if (imagePath != null) {
        _image = File(imagePath);
      }

      _isProfileLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                setState(() {
                  isEditMode = !isEditMode;
                });
              },
            ),
          ],
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoaded) {
              return Form(
                key: _formKey,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: _image != null
                                ? FileImage(_image!)
                                : const AssetImage('asset/star.png')
                                    as ImageProvider,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildProfileField('Name', nameController,
                          inputFormatters: textOnlyFormatter,
                          keyboardType: TextInputType.text),
                      _buildProfileField('Position', positionController,
                          inputFormatters: textOnlyFormatter,
                          keyboardType: TextInputType.text),
                      _buildProfileField('Employee ID', employeeIdController,
                          inputFormatters: phoneNumberFormatter,
                          keyboardType: TextInputType.phone),
                      _buildProfileField('Contact No.', contactNoController,
                          inputFormatters: phoneNumberFormatter,
                          keyboardType: TextInputType.phone),
                      _buildProfileField(
                          'Emergency Contact', emergencyContactController,
                          inputFormatters: phoneNumberFormatter,
                          keyboardType: TextInputType.phone),
                      InkWell(
                        onTap: () => _selectedDOB(context),
                        child: AbsorbPointer(
                          child: _buildProfileField('DOB', dobController,
                              readOnly: true),
                        ),
                      ),
                      _buildProfileField('Blood Type', bloodTypeController,
                          inputFormatters: bloodTypeFormatter),
                      InkWell(
                        onTap: () => _selectedappointment(context),
                        child: AbsorbPointer(
                          child: _buildProfileField(
                              'Appointed Date', appointedDateController),
                        ),
                      ),
                      _buildProfileField('PAN No.', panNoController,
                          inputFormatters: panNumberFormatter,
                          keyboardType: TextInputType.number),
                      const SizedBox(height: 20),
                      if (isEditMode)
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await _saveProfile();
                              if (widget.employeeId == null ||
                                  widget.employeeId!.isEmpty) {
                                context
                                    .read<ProfileBloc>()
                                    .add(CreateProfileEvent(
                                      name: nameController.text,
                                      position: positionController.text,
                                      contactNo: contactNoController.text,
                                      emergencyContact:
                                          emergencyContactController.text,
                                      dob: dobController.text,
                                      bloodType: bloodTypeController.text,
                                      appointedDate:
                                          appointedDateController.text,
                                      panNo: panNoController.text,
                                      image: _image,
                                      employeeId: employeeIdController.text,
                                    ));
                              } else {
                                context
                                    .read<ProfileBloc>()
                                    .add(UpdateProfileEvent(
                                      name: nameController.text,
                                      position: positionController.text,
                                      employeeId: widget.employeeId!,
                                      contactNo: contactNoController.text,
                                      emergencyContact:
                                          emergencyContactController.text,
                                      dob: dobController.text,
                                      bloodType: bloodTypeController.text,
                                      appointedDate:
                                          appointedDateController.text,
                                      panNo: panNoController.text,
                                      image: _image,
                                    ));
                              }
                              setState(() {
                                isEditMode = false;
                              });
                            }
                          },
                          child: const Text('Save Profile'),
                        ),
                    ],
                  ),
                ),
              );
            } else if (state is ProfileError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildProfileField(
    String label,
    TextEditingController controller, {
    bool readOnly = false,
    List<TextInputFormatter>? inputFormatters,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        readOnly: !isEditMode || readOnly,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$label is required';
          }
          if (label == 'DOB' || label == 'Appointed Date') {
            return dateValidator(value);
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: label,
          border: const OutlineInputBorder(),
          enabled: isEditMode && !readOnly,
        ),
      ),
    );
  }

  Future<void> _selectedDOB(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectDOB ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _selectDOB = pickedDate;
        dobController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  Future<void> _selectedappointment(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectAppointment ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _selectAppointment = pickedDate;
        appointedDateController.text =
            DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  String? dateValidator(String date) {
    try {
      DateFormat('yyyy-MM-dd').parseStrict(date);
      return null;
    } catch (e) {
      return 'Invalid date format';
    }
  }
}
