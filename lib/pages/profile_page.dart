import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;

  Future<void> _pickedimage() async {
    final pickedfile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedfile != null) {
      setState(() {
        _image = File(pickedfile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('asset/dashboard.png'),
        fit: BoxFit.cover,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 30),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    margin: const EdgeInsets.only(left: 20, top: 10),
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    )),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(37, 38, 39, 0.64),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.7),
                        spreadRadius: 5,
                        blurRadius: 100,
                        blurStyle: BlurStyle.inner)
                  ],
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(37, 38, 39, 0.64),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: _image != null
                            ? Image.file(_image!)
                            : Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: const Icon(
                                  Icons.person,
                                  size: 80,
                                  color: Color.fromARGB(255, 183, 124, 120),
                                ),
                              )),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'Emily Browser',
                      style: TextStyle(color: Colors.white),
                    ),
                    const Text(
                      'Senior UI/Ux Engineer',
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(
                            Icons.call,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    _profiledetial('Employee ID', '201'),
                    _buildDivider(),
                    _profiledetial('Contact no.', '983834343'),
                    _buildDivider(),
                    _profiledetial('Emerrgency Contact no.', '98384843'),
                    _buildDivider(),
                    _profiledetial('DOB', '20-04-2004'),
                    _buildDivider(),
                    _profiledetial('Blood Type', 'B+'),
                    _buildDivider(),
                    _profiledetial('Appointed Date', '12-03-2019'),
                    _buildDivider(),
                    _profiledetial('PAN no.', '2014324'),
                    _buildDivider(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _profiledetial(String text, String value) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: const TextStyle(color: Color.fromARGB(255, 197, 165, 165)),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 18, color: Colors.white),
        )
      ],
    ),
  );
}

// Divider for profile details
Widget _buildDivider() {
  return const Divider(
    height: 25,
    endIndent: 20,
    indent: 20,
    thickness: 0.3,
  );
}
