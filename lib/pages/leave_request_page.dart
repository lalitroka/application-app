import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstdemo/database/leave_request.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LeaveRequestPage extends StatefulWidget {
  const LeaveRequestPage({super.key});

  @override
  State<LeaveRequestPage> createState() => _LeaveRequestPageState();
}

class _LeaveRequestPageState extends State<LeaveRequestPage> {
  final TextEditingController _leaveController = TextEditingController();

  final TextEditingController _dateFromController = TextEditingController();

  final TextEditingController _dateToController = TextEditingController();
  final TextEditingController _substitueController = TextEditingController();

  final TextEditingController _workStatusController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  String _approver = '';

  bool ispressed = false;

  DateTime? _selectFromDate;
  void _selectedFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectFromDate ?? DateTime.now(),
      firstDate: DateTime(1999),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectFromDate) {
      setState(() {
        _selectFromDate = picked;
        _dateFromController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  DateTime? _selectToDate;
  void _selectedToDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectToDate ?? DateTime.now(),
      firstDate: DateTime(1999),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectFromDate) {
      setState(() {
        _selectFromDate = picked;
        _dateToController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  List<Map<String, dynamic>> filterList = [];

  String searchQuery = '';

  void updateSearchQuery(String query) async {
    if (query.isNotEmpty) {
      QuerySnapshot personalSnapshot = await FirebaseFirestore.instance
          .collection('profiles')
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThanOrEqualTo: query + '\uf8ff')
          .get();

      setState(() {
        filterList = personalSnapshot.docs.map((doc) {
          return {
            'name': doc['name'],
            'position': doc['position'],
            'imageUrl': doc['imageUrl'] ?? '',
          };
        }).toList();
      });
    } else {
      setState(() {
        filterList = [];
      });
    }
  }

  void showSearchButton() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Search Personal',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (query) => updateSearchQuery(query),
                  ),
                ),
                Expanded(
                    child: filterList.isNotEmpty
                        ? ListView.builder(
                            itemCount: filterList.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      filterList[index]['imageUrl']!.isNotEmpty
                                          ? NetworkImage(
                                              filterList[index]['imageUrl']!)
                                          : AssetImage('asset/star.png'),
                                ),
                                title: Text(filterList[index]['name']!),
                                subtitle: Text(filterList[index]['position']!),
                                onTap: () {
                                  Navigator.pop(context, filterList[index]);
                                },
                              );
                            })
                        : const Center(
                            child: Text('No User found'),
                          )),
              ],
            ),
          );
        }).then((selectedPersonal) {
      if (selectedPersonal.isNotEmpty) {
        setState(() {
          _substitueController.text = selectedPersonal['name']!;
        });
      }
    });
  }

  void showSearchApprover() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Search Approver',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (query) => updateSearchQuery(query),
                  ),
                ),
                Expanded(
                    child: filterList.isNotEmpty
                        ? ListView.builder(
                            itemCount: filterList.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      filterList[index]['imageUrl']!.isNotEmpty
                                          ? NetworkImage(
                                              filterList[index]['imageUrl']!)
                                          : AssetImage('asset/star.png'),
                                ),
                                title: Text(filterList[index]['name']!),
                                subtitle: Text(filterList[index]['position']!),
                                onTap: () {
                                  Navigator.pop(context, filterList[index]);
                                },
                              );
                            })
                        : const Center(
                            child: Text('No User found'),
                          )),
              ],
            ),
          );
        }).then((selectedPersonal) {
      if (selectedPersonal.isNotEmpty) {
        setState(() {
          _approver = selectedPersonal['name']!;
        });
      }
    });
  }

  void _submitLeaveRequest() async {
    if (_leaveController.text.isEmpty ||
        _dateFromController.text.isEmpty ||
        _dateToController.text.isEmpty ||
        _substitueController.text.isEmpty ||
        _workStatusController.text.isEmpty ||
        selectedLeaveType.isEmpty ||
        _reasonController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    try {
      // Prepare the data to send to Firestore
      Map<String, dynamic> leaveRequest = {
        'leaveType': _leaveController.text,
        'fromDate': _dateFromController.text,
        'toDate': _dateToController.text,
        'substitutePersonnel': _substitueController.text,
        'workStatus': _workStatusController.text,
        'selectedLeaveType': selectedLeaveType,
        'reason': _reasonController.text,
        'status': 'pending', // Initial status
        'approverId': 'approver_user_id', // Replace with actual approver ID
      };

      // Add the leave request to Firestore
      await FirebaseFirestore.instance
          .collection('leaveRequests')
          .add(leaveRequest);

      // Insert the leave request into the local database
      await LeaveRequestDatabase().insertLeaveRequest(leaveRequest);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Leave request submitted successfully!')),
      );

      // Optionally, navigate back or clear the form
      Navigator.pop(context);
    } catch (e) {
      // Handle error (e.g., show error message)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error submitting leave request: $e')),
      );
    }
  }

  int selectButton = -1;
  String selectedLeaveType = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: SingleChildScrollView(
              child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white,
                        ),
                        margin: const EdgeInsets.all(5),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.grey[600],
                        )),
                  ),
                  const Text(
                    'Apply Leave',
                    style:
                        TextStyle(fontSize: 17.28, fontWeight: FontWeight.w600),
                  ),
                  Container(
                    height: 30,
                    width: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                    ),
                    margin: const EdgeInsets.all(5),
                    child: Icon(
                      Icons.line_weight_outlined,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _topcontainer(
                      'leave left',
                      18,
                      const Color.fromRGBO(47, 155, 242, 1),
                    ),
                    _topcontainer(
                      'leave token ',
                      1,
                      const Color.fromRGBO(236, 81, 81, 1),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Leave Approver'),
                  InkWell(
                    onTap: () {
                      showSearchApprover();
                    },
                    child: Text(
                      _approver.isNotEmpty ? _approver : ' SelectApprover',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 114, 83, 83)),
                    ),
                  )
                ],
              ),
              const Divider(
                height: 20,
              ),
              const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Leave Type",
                  )),
              _textFieldContainer('casual leave', _leaveController),
              const SizedBox(
                height: 10,
              ),
              const Align(
                  alignment: Alignment.bottomLeft, child: Text('Leave For')),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Full Day Button
                  TextButton(
                    onPressed: selectButton != 0
                        ? () {
                            setState(() {
                              selectButton =
                                  0; // Set selected button index to 0
                              selectedLeaveType =
                                  'Full Day'; // Update selected leave type
                            });
                          }
                        : null,
                    child: Container(
                      height: 40,
                      width: 80,
                      decoration: BoxDecoration(
                        color: selectButton == 0 ? Colors.black : Colors.green,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Center(
                        child: Text('Full Day',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),

                  // First Half Button
                  TextButton(
                    onPressed: selectButton != 1
                        ? () {
                            setState(() {
                              selectButton =
                                  1; // Set selected button index to 1
                              selectedLeaveType =
                                  'First Half'; // Update selected leave type
                            });
                          }
                        : null,
                    child: Container(
                      height: 40,
                      width: 80,
                      decoration: BoxDecoration(
                        color: selectButton == 1 ? Colors.black : Colors.green,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Center(
                        child: Text('First Half',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),

                  // Second Half Button
                  TextButton(
                    onPressed: selectButton != 2
                        ? () {
                            setState(() {
                              selectButton =
                                  2; // Set selected button index to 2
                              selectedLeaveType =
                                  'Second Half'; // Update selected leave type
                            });
                          }
                        : null,
                    child: Container(
                      height: 40,
                      width: 80,
                      decoration: BoxDecoration(
                        color: selectButton == 2 ? Colors.black : Colors.green,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Center(
                        child: Text('Second Half',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                SizedBox(
                  width: 150,
                  child: Column(
                    children: [
                      const Align(
                          alignment: Alignment.bottomLeft, child: Text('From')),
                      GestureDetector(
                        onTap: () {
                          _selectedFromDate(context);
                        },
                        child: _dateContainer(_dateFromController),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: Column(
                    children: [
                      const Align(
                          alignment: Alignment.bottomLeft, child: Text('To')),
                      GestureDetector(
                        onTap: () {
                          _selectedToDate(context);
                        },
                        child: _dateContainer(_dateToController),
                      ),
                    ],
                  ),
                ),
              ]),
              const SizedBox(
                height: 10,
              ),
              const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text('Substitue Personnel')),
              InkWell(
                onTap: () {
                  showSearchButton();
                },
                child: Center(
                  child: IgnorePointer(
                    child: _textFieldContainer(
                        'search personal', _substitueController),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text('Current Work Status')),
              Container(
                height: 42,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: _textFieldContainer('labeltext', _workStatusController),
              ),
              const SizedBox(
                height: 10,
              ),
              const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text('Reason for leave')),
              SizedBox(
                height: 100,
                child: Container(
                    height: 42,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: _reasonController,
                      textAlignVertical: TextAlignVertical.top,
                      expands: true,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                    )),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(5),
                ),
                margin: const EdgeInsets.only(top: 10, bottom: 5),
                width: double.infinity,
                height: 40,
                child: GestureDetector(
                  onTap: () {
                    _submitLeaveRequest();
                  },
                  child: const Center(
                    child: Text(
                      "Apply",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ))),
    );
  }
}

Widget _topcontainer(String title, int value, Color boxColor) {
  return Stack(children: [
    Container(
      height: 80,
      width: 160,
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.circular(5),
      ),
    ),
    Positioned(
        top: 5,
        left: 5,
        child: Text(
          title,
          style: const TextStyle(color: Colors.white),
        )),
    Positioned(
        right: 15,
        bottom: 10,
        child: Text(
          value.toString(),
          style: const TextStyle(fontSize: 20, color: Colors.white),
        )),
  ]);
}

Widget _textFieldContainer(
    String? labeltext, TextEditingController controllerType) {
  return Container(
    height: 42,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5), color: Colors.white),
    child: TextField(
      controller: controllerType,
      decoration: const InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        hintText: "Casual Leave(sick+emergency)",
      ),
    ),
  );
}

Widget _dateContainer(TextEditingController dateContoller) {
  return Container(
    height: 42,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
    ),
    child: TextField(
      enabled: false,
      controller: dateContoller,
      decoration: const InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
      ),
    ),
  );
}
