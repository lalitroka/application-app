import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'profile_state.dart';

part 'profile_event.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc()
      : super(const ProfileLoaded(
          name: 'Default Name',
          position: 'Default Position',
          employeeId: 'Default Employee ID',
          contactNo: 'Default Contact No',
          emergencyContact: 'Default Emergency Contact',
          dob: 'Default DOB',
          bloodType: 'Default Blood Type',
          appointedDate: 'Default Appointed Date',
          panNo: 'Default PAN No',
          image: null,
        )) {
    on<LoadProfileEvent>(_onLoadProfile);
    on<CreateProfileEvent>(_onCreateProfile);
    on<UpdateProfileEvent>(_onUpdateProfile);
    on<PickImageEvent>(_onPickImage);
  }

  Future<void> _onLoadProfile(
      LoadProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());

    try {
      if (event.employeeId != null) {
        // Load existing profile from Firestore
        DocumentSnapshot profileSnapshot = await FirebaseFirestore.instance
            .collection('profiles')
            .doc(event.employeeId)
            .get();

        if (profileSnapshot.exists) {
          // Extract profile data and emit ProfileLoaded state
          Map<String, dynamic> data =
              profileSnapshot.data() as Map<String, dynamic>;
          emit(ProfileLoaded(
            name: data['name'] ?? 'unknown',
            position: data['position'] ?? 'unknown',
            employeeId: data['employeeId'] ?? 'unknown',
            contactNo: data['contactNo'] ?? 'unknown',
            emergencyContact: data['emergencyContact'] ?? 'unknown',
            dob: data['dob'] ?? 'unknown',
            bloodType: data['bloodType'] ?? 'unknown',
            appointedDate: data['appointedDate'] ?? 'unknown',
            panNo: data['panNo'] ?? 'unknown',
            image: null, // Handle image loading separately
          ));
        }
      } else {
        // Generate new employee ID and emit default values
        String newEmployeeId =
            FirebaseFirestore.instance.collection('profiles').doc().id;
        emit(ProfileLoaded(
          name: 'unknown',
          position: 'unknown',
          employeeId: newEmployeeId,
          contactNo: 'unknown',
          emergencyContact: 'unknown',
          dob: 'unknown',
          bloodType: 'unknown',
          appointedDate: 'unknown',
          panNo: 'unknown',
          image: null,
        ));
      }
    } catch (e) {
      emit(ProfileError('Failed to load profile: $e'));
    }
  }

  Future<void> _onCreateProfile(
      CreateProfileEvent event, Emitter<ProfileState> emit) async {
    try {
      // Upload the image if there is one
      String? imageUrl;
      if (event.image != null) {
        imageUrl = await _uploadImage(event.image!);
      }

      // Profile data to save
      Map<String, dynamic> profileData = {
        'name': event.name,
        'position': event.position,
        'employeeId': event.employeeId,
        'contactNo': event.contactNo,
        'emergencyContact': event.emergencyContact,
        'dob': event.dob,
        'bloodType': event.bloodType,
        'appointedDate': event.appointedDate,
        'panNo': event.panNo,
        'imageUrl':
            imageUrl ?? 'default_image_url', // Use default image if none
      };

      // New profile creation: generate employeeId manually
      String newEmployeeId = event.employeeId;

      // Save new profile to Firestore with custom employeeId
      await FirebaseFirestore.instance
          .collection('profiles')
          .doc(newEmployeeId)
          .set(profileData, SetOptions(merge: true));

      // Emit updated profile state
      emit(ProfileLoaded(
        name: event.name,
        position: event.position,
        employeeId: newEmployeeId,
        contactNo: event.contactNo,
        emergencyContact: event.emergencyContact,
        dob: event.dob,
        bloodType: event.bloodType,
        appointedDate: event.appointedDate,
        panNo: event.panNo,
        image: event.image,
      ));
    } catch (e) {
      emit(ProfileError('Error creating profile: $e'));
    }
  }

  Future<void> _onUpdateProfile(
      UpdateProfileEvent event, Emitter<ProfileState> emit) async {
    try {
      // Upload the image if there is one
      String? imageUrl;
      if (event.image != null) {
        imageUrl = await _uploadImage(event.image!);
      }

      // Profile data to save
      Map<String, dynamic> profileData = {
        'name': event.name,
        'position': event.position,
        'employeeId': event.employeeId,
        'contactNo': event.contactNo,
        'emergencyContact': event.emergencyContact,
        'dob': event.dob,
        'bloodType': event.bloodType,
        'appointedDate': event.appointedDate,
        'panNo': event.panNo,
        'imageUrl':
            imageUrl ?? 'default_image_url', // Use default image if none
      };

      // Editing an existing profile: update only the provided fields
      await FirebaseFirestore.instance
          .collection('profiles')
          .doc(event.employeeId)
          .update(profileData);

      // Emit updated profile state
      emit(ProfileLoaded(
        name: event.name,
        position: event.position,
        employeeId: event.employeeId,
        contactNo: event.contactNo,
        emergencyContact: event.emergencyContact,
        dob: event.dob,
        bloodType: event.bloodType,
        appointedDate: event.appointedDate,
        panNo: event.panNo,
        image: event.image,
      ));
    } catch (e) {
      emit(ProfileError('Error updating profile: $e'));
    }
  }

  Future<void> _onPickImage(
      PickImageEvent event, Emitter<ProfileState> emit) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      emit(ImagePickedState(File(pickedFile.path)));
    }
  }

  Future<String?> _uploadImage(File image) async {
    try {
      String fileName = 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
      Reference storageRef =
          FirebaseStorage.instance.ref().child('profile_images/$fileName');

      // Upload the file
      UploadTask uploadTask = storageRef.putFile(image);
      TaskSnapshot snapshot = await uploadTask;

      // Get the download URL
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      return null;
    }
  }
}
