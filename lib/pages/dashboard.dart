import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final month = DateFormat('dd MMM').format(DateTime.now());
  final dayName = DateFormat('EEEE').format(DateTime.now());
  final currentTime = DateFormat('HH:mm').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('asset/dashboard.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top Search and Notification Row
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildIcon(Icons.search_outlined),
                    const SizedBox(width: 10),
                    _buildIcon(Icons.notifications_outlined),
                  ],
                ),
              ),

              // Date, Day, and Time Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
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

              const SizedBox(
                height: 346,
              ),

              // Icons Row (Leave, Attendance, Review, Setting)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildFeatureBox(
                      icon: Icons.star,
                      label: 'Leave',
                      iconColor: Colors.grey[600],
                    ),
                    _buildFeatureBox(
                      imagePath: 'asset/userdelete.png',
                      label: 'Attendance',
                    ),
                    _buildFeatureBox(
                      imagePath: 'asset/star.png',
                      label: 'Review',
                    ),
                    _buildFeatureBox(
                      imagePath: 'asset/star.png',
                      label: 'Setting',
                    ),
                  ],
                ),
              ),

              // DraggableScrollableSheet Section
              DraggableScrollableSheet(
                initialChildSize: 0.7,
                minChildSize: 0.6,
                maxChildSize: 0.90,
                builder: (context, scrollController) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 15,
                        ),
                      ],
                    ),
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: 10, // Sample item count
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text('Item $index'),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method for creating icons in a circle box
  Widget _buildIcon(IconData iconData) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(50),
        ),
        height: 40,
        width: 40,
        child: Icon(
          iconData,
          size: 24,
          color: Colors.black,
        ),
      ),
    );
  }

  // Helper method to build feature boxes with either icon or image
  Widget _buildFeatureBox(
      {IconData? icon,
      String? imagePath,
      required String label,
      Color? iconColor}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 76,
      width: 76,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            Icon(
              icon,
              color: iconColor ?? Colors.white,
              size: 30,
            )
          else if (imagePath != null)
            Image.asset(
              imagePath,
              height: 30,
              width: 30,
            ),
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
}
