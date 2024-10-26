import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

// Initial state
class ProfileInitial extends ProfileState {}

// State when profile is being loaded
class ProfileLoading extends ProfileState {}

// State when profile is loaded
class ProfileLoaded extends ProfileState {
  final String name;
  final String position;
  final String employeeId;
  final String contactNo;
  final String emergencyContact;
  final String dob;
  final String bloodType;
  final String appointedDate;
  final String panNo;
  final File? image;

  const ProfileLoaded(
      {this.name = 'Default Name',
      this.position = 'Default Position',
      this.employeeId = 'Default Employee ID',
      this.contactNo = 'Default Contact No',
      this.emergencyContact = 'Default Emergency Contact',
      this.dob = 'Default DOB',
      this.bloodType = 'Default Blood Type',
      this.appointedDate = 'Default Appointed Date',
      this.panNo = 'Default PAN No',
      this.image});
}

// State when an image is picked
class ImagePickedState extends ProfileState {
  final File image;

  const ImagePickedState(this.image);
}

// State when an error occurs
class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);
}
