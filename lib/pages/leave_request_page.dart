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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
              child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
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
                  const Text(
                    'Apply Leave',
                    style:
                        TextStyle(fontSize: 17.28, fontWeight: FontWeight.w600),
                  ),
                  Container(
                    height: 40,
                    width: 40,
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
                    Stack(children: [
                      Container(
                        height: 80,
                        width: 170,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(47, 155, 242, 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      const Positioned(
                          top: 5,
                          left: 5,
                          child: Text(
                            'Leave Left',
                            style: TextStyle(color: Colors.white),
                          )),
                      const Positioned(
                          right: 15,
                          bottom: 10,
                          child: Text(
                            '18',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          )),
                    ]),
                    Stack(children: [
                      Container(
                        height: 80,
                        width: 170,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(236, 81, 81, 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      const Positioned(
                          top: 5,
                          left: 5,
                          child: Text(
                            'Leave Left',
                            style: TextStyle(color: Colors.white),
                          )),
                      const Positioned(
                          right: 15,
                          bottom: 10,
                          child: Text(
                            '18',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          )),
                    ]),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Leave Approver'),
                  Text(
                    'Smaran Duwadi',
                    style: TextStyle(color: Color.fromARGB(255, 114, 83, 83)),
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
              Container(
                height: 42,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white),
                child: TextField(
                  controller: _leaveController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    hintText: "Casual Leave(sick+emergency)",
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Align(
                  alignment: Alignment.bottomLeft, child: Text('Leave For')),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                      onPressed: () {
                        setState(() {
                          ispressed = !ispressed;
                        });
                      },
                      child: Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(
                            color: ispressed ? Colors.black : Colors.green,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Center(
                              child: Text('Full Day ',
                                  style: TextStyle(color: Colors.white))))),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          ispressed = !ispressed;
                        });
                      },
                      child: Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(
                            color: ispressed ? Colors.black : Colors.green,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Center(
                              child: Text('First Half',
                                  style: TextStyle(color: Colors.white))))),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          ispressed = !ispressed;
                        });
                      },
                      child: Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: ispressed ? Colors.blue : Colors.green,
                          ),
                          child: const Center(
                              child: Text(
                            'Second Half',
                            style: TextStyle(color: Colors.white),
                          )))),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                SizedBox(
                  width: 180,
                  child: Column(
                    children: [
                      const Align(
                          alignment: Alignment.bottomLeft, child: Text('From')),
                      GestureDetector(
                        onTap: () {
                          _selectedFromDate(context);
                        },
                        child: Container(
                          height: 42,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextField(
                            enabled: false,
                            controller: _dateFromController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 180,
                  child: Column(
                    children: [
                      const Align(
                          alignment: Alignment.bottomLeft, child: Text('To')),
                      GestureDetector(
                        onTap: () {
                          _selectedToDate(context);
                        },
                        child: Container(
                          height: 42,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: _dateToController,
                            enabled: false,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                            ),
                          ),
                        ),
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
              Container(
                height: 42,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
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
                child: Container(
                  height: 42,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                  ),
                ),
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
                    child: const TextField(
                      textAlignVertical: TextAlignVertical.top,
                      expands: true,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
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
                  onTap: () {},
                  child: const Center(
                    child: Text(
                      "Login",
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
