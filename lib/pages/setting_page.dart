import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final List<File> _images = []; // List to store selected images

  // Method to pick an image from the gallery
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _images.add(File(pickedFile.path));
      });
    }
  }

  bool _isbuttomtap = false;

  void _tooglebutton(bool value) {
    setState(() {
      _isbuttomtap = value;
    });
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 40),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    size: 30,
                  ),
                ),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 10,
                    ),
                    const Center(
                      child: Text(
                        'Settings',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.pushNamed(context, '/profilepage'),
                      child: const ListTile(
                        leading: Icon(
                          Icons.person_outline,
                          color: Colors.white,
                        ),
                        title: Text(
                          'Profile',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const Divider(
                      endIndent: 20,
                      indent: 20,
                      height: 10,
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.person_2_outlined,
                        color: Colors.white,
                      ),
                      title: const Text(
                        'Auto Check-in',
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: Transform.scale(
                        scaleX: 1,
                        scaleY: 0.9,
                        child: Switch(
                          value: _isbuttomtap,
                          onChanged: _tooglebutton,
                          activeColor: Colors.blue,
                          inactiveThumbColor: Colors.grey,
                          inactiveTrackColor: Colors.white,
                        ),
                      ),
                    ),
                    const Divider(
                      endIndent: 20,
                      indent: 20,
                      height: 10,
                    ),
                    const ListTile(
                      leading: Icon(
                        Icons.image,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Display Wallpaper',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _images.isEmpty
                        ? Container(
                            margin: const EdgeInsets.only(left: 45),
                            width: 70,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.white,
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.red,
                              size: 30,
                            ),
                          )
                        : GridView.builder(
                            itemCount: _images.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.file(
                                  _images[index],
                                  height: 60,
                                  width: 80,
                                  fit: BoxFit.cover,
                                ),
                              );
                            }),
                    const SizedBox(
                      height: 14,
                    ),
                    const Divider(
                      endIndent: 20,
                      indent: 20,
                    ),
                    const ListTile(
                      leading: Icon(
                        Icons.logout_sharp,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Logout',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const Divider(
                      endIndent: 20,
                      indent: 20,
                      height: 10,
                    ),
                    const ListTile(
                      leading: Icon(
                        Icons.info_outline,
                        color: Colors.white,
                      ),
                      title: Text(
                        'About App',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
