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

  int visibleImages = 5;

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
                        onTap: () =>
                            Navigator.pushNamed(context, '/profilepage'),
                        child: _listTile(
                            'profile', const Icon(Icons.person_outlined))),
                    divider(),
                    _listTile(
                      'Auto Check-in ',
                      const Icon(Icons.person_2),
                      iconT: Transform.scale(
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
                    divider(),
                    _listTile('Display Wallpaper', const Icon(Icons.image)),
                    const SizedBox(
                      height: 10,
                    ),
                    _images.isEmpty
                        ? InkWell(
                            onTap: () {
                              _pickImage();
                            },
                            child: Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: Colors.white,
                              ),
                              child: const Icon(
                                Icons.add,
                                color: Colors.red,
                                size: 30,
                              ),
                            ),
                          )
                        : GridView.builder(
                            shrinkWrap:
                                true, // Helps to avoid unbounded height errors
                            itemCount: _images.length > visibleImages
                                ? visibleImages + 1
                                : _images.length + 1,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 8.0,
                              childAspectRatio: 1,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              if (index == 0) {
                                return InkWell(
                                  onTap: () {
                                    _pickImage();
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      color: Colors.white,
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.red,
                                      size: 30,
                                    ),
                                  ),
                                );
                              } else if (_images.length > visibleImages &&
                                  index == visibleImages) {
                                // If there are more than visibleImages, show "See More" button
                                return InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context,
                                        '/photopage'); // Navigate to another screen or modal
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      color: Colors.grey[200],
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "See More",
                                        style: TextStyle(
                                            color: Colors.blue, fontSize: 16),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.file(
                                    _images[index - 1],
                                    height: 60,
                                    width: 80,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              }
                            },
                          ),
                    const SizedBox(
                      height: 14,
                    ),
                    const Divider(
                      endIndent: 20,
                      indent: 20,
                    ),
                    _listTile('Logout', const Icon(Icons.logout_outlined)),
                    divider(),
                    _listTile('About App', const Icon(Icons.info_outline)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget divider() {
    return const Divider(
      endIndent: 20,
      indent: 20,
      height: 10,
    );
  }

  void _showMoreImages() {}
}

Widget _listTile(String titleName, Icon iconL, {Widget? iconT}) {
  return ListTile(
    leading: Icon(
      iconL.icon,
      color: Colors.white,
    ),
    title: Text(
      titleName,
      style: const TextStyle(color: Colors.white),
    ),
    trailing: iconT,
  );
}
