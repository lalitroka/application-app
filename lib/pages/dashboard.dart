import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late final screenWidth = MediaQuery.of(context).size.width;
  late final screenHeight = MediaQuery.of(context).size.height;

  final month = DateFormat('dd MMM').format(DateTime.now());
  final dayName = DateFormat('EEEE').format(DateTime.now());
  final currentTime = DateFormat('HH:mm').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('asset/dashboard.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Top Search and Notification Row

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.08,
                    vertical: screenHeight * 0.07,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: _buildIcon(Icons.arrow_back)),
                      _buildIcon(Icons.search_outlined),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/notificationpage');
                        },
                        child: _buildIcon(Icons.notifications_outlined),
                      ),
                    ],
                  ),
                ),

                // Date, Day, and Time Section
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.08,
                      vertical: screenHeight * 0.10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dayName,
                        style: TextStyle(
                          fontSize: 20.74,
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        month,
                        style: TextStyle(
                          fontSize: 20.74,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey[500],
                        ),
                      ),
                      Text(
                        currentTime,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.74,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),

                // Icons Row (Leave, Attendance, Review, Setting)

                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenHeight * 0.22),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/leaverequestpage');
                          },
                          child: _buildFeatureBox(
                              icon: Icons.star, label: 'Leave')),
                      _buildFeatureBox(
                        imagePath: 'asset/userdelete.png',
                        label: 'Attendance',
                      ),
                      InkWell(
                        onTap: () =>
                            Navigator.pushNamed(context, '/leavelistingpage'),
                        child: _buildFeatureBox(
                          imagePath: 'asset/star.png',
                          label: 'Review',
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/settingpage');
                        },
                        child: _buildFeatureBox(
                          imagePath: 'asset/star.png',
                          label: 'Setting',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // DraggableScrollableSheet for feature
          DraggableScrollableSheet(
            initialChildSize: 0.13,
            minChildSize: 0.13,
            maxChildSize: 0.47,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(37, 38, 39, 0.64),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.61),
                        spreadRadius: 5,
                        blurRadius: 100,
                        blurStyle: BlurStyle.inner)
                  ],
                ),
                child: ListView(
                  controller: scrollController,
                  children: [
                    const Divider(
                      height: 0.1,
                      endIndent: 180,
                      indent: 180,
                      thickness: 5,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SafeArea(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Hello, Ayush!',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Icon(
                                  Icons.settings,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),

                          const SizedBox(height: 8),
                          const Text(
                            'Checked in, 10:00am',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Add leave info here as in the design
                          const Divider(
                            endIndent: 20,
                            indent: 20,
                            thickness: 3,
                            color: Color.fromARGB(255, 70, 69, 69),
                          ),

                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildLeaveInfo('Leaves Taken', '0.0'),
                              _buildLeaveInfo('Remaining Leaves', '18.0'),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildLeaveInfo('Employees on Leave', '1'),
                              Flexible(
                                child: _buildLeaveInfo(
                                    'Pending Leave Request', '2'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          const Divider(
                            endIndent: 20,
                            indent: 20,
                            thickness: 3,
                            color: Color.fromARGB(255, 70, 69, 69),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // Helper method for creating icons in a circle box
  Widget _buildIcon(IconData iconData) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 141, 140, 140),
        borderRadius: BorderRadius.circular(50),
      ),
      height: 35,
      width: 35,
      child: Icon(
        iconData,
        size: 24,
        color: Colors.black,
      ),
    );
  }

  // Helper method to build feature boxes with either icon or image
  Widget _buildFeatureBox({
    IconData? icon,
    String? imagePath,
    required String label,
    Color? iconColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(37, 38, 39, 0.64),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 76,
      width: 76,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon != null
              ? Icon(
                  icon,
                  color: iconColor ?? Colors.white,
                  size: 30,
                )
              : Image.asset(imagePath.toString()),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build leave information in draggable sheet
  Widget _buildLeaveInfo(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
