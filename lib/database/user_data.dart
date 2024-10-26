class Profile {
  final String name;
  final String position;
  final String employeeId;
  final String contactNo;
  final String emergencyContact;
  final String dob;
  final String bloodType;
  final String appointedDate;
  final String panNo;
  final String? imageUrl;

  Profile({
    required this.name,
    required this.position,
    required this.employeeId,
    required this.contactNo,
    required this.emergencyContact,
    required this.dob,
    required this.bloodType,
    required this.appointedDate,
    required this.panNo,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'position': position,
      'employeeId': employeeId,
      'contactNo': contactNo,
      'emergencyContact': emergencyContact,
      'dob': dob,
      'bloodType': bloodType,
      'appointedDate': appointedDate,
      'panNo': panNo,
      'imageUrl': imageUrl,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      name: map['name'],
      position: map['position'],
      employeeId: map['employeeId'],
      contactNo: map['contactNo'],
      emergencyContact: map['emergencyContact'],
      dob: map['dob'],
      bloodType: map['bloodType'],
      appointedDate: map['appointedDate'],
      panNo: map['panNo'],
      imageUrl: map['imageUrl'],
    );
  }
}
