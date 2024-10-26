part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

// Event to load a profile (either new or existing)
class LoadProfileEvent extends ProfileEvent {
  final String? employeeId;

  const LoadProfileEvent(this.employeeId);
}

// Event to update the profile
class UpdateProfileEvent extends ProfileEvent {
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

  const UpdateProfileEvent({
    required this.name,
    required this.position,
    required this.employeeId,
    required this.contactNo,
    required this.emergencyContact,
    required this.dob,
    required this.bloodType,
    required this.appointedDate,
    required this.panNo,
    this.image,
  });
}

// Event to pick an image
class PickImageEvent extends ProfileEvent {}

class CreateProfileEvent extends ProfileEvent {
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
  const CreateProfileEvent({
    required this.name,
    required this.position,
    required this.employeeId,
    required this.contactNo,
    required this.emergencyContact,
    required this.dob,
    required this.bloodType,
    required this.appointedDate,
    required this.panNo,
    required this.image,
  });
}
















// abstract class ProfileEvent {}

// class PickImageEvent extends ProfileEvent {
//   final String imagePath;
//   PickImageEvent(this.imagePath);
// }

// class SaveProfileEvent extends ProfileEvent {
//   final String name;
//   final String position;
//   final String employeeId;
//   final String contactNo;
//   final String emergencyContact;
//   final String dob;
//   final String bloodType;
//   final String appointedDate;
//   final String panNo;

//   SaveProfileEvent({
//     required this.name,
//     required this.position,
//     required this.employeeId,
//     required this.contactNo,
//     required this.emergencyContact,
//     required this.dob,
//     required this.bloodType,
//     required this.appointedDate,
//     required this.panNo,
//   });
// }
