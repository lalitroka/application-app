import 'package:flutter/material.dart';

class LeaveListingPage extends StatefulWidget {
  const LeaveListingPage({super.key});

  @override
  State<LeaveListingPage> createState() => _LeaveListingPageState();
}

class _LeaveListingPageState extends State<LeaveListingPage>
    with SingleTickerProviderStateMixin {


  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.all(5),
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.white,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        title: const Row(
          children: [
            SizedBox(
              width: 50,
            ),
            Text('Leave Listing'),
          ],
        ),
        backgroundColor: Colors.grey[200],
        bottom: TabBar(controller: _tabController, tabs: const [
          Tab(
            text: 'My Leave',
          ),
          Tab(
            text: 'Leave Request',
          )
        ]),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _myLeaveTab(),
          _leaveRequestTab(),
        ],
      ),
    );
  }

  Widget _myLeaveTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pending',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ListView.builder(
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: (context, int index) {
                return _leaveCard('Personal Leave', '2020-01-17', true,
                    isPending: true);
              }),
          const SizedBox(height: 20),
          const Text(
            'History',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: (BuildContext, int index) {
                return _leaveCard('Personal Leave', '2020-01-17', true,
                    isPending: true);
              }),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _leaveRequestTab() {
    return Center(
        child: ListView.builder(
            itemCount: 2,
            itemBuilder: (BuildContext, int index) {
              return InkWell(
                  onTap: () => requestDetial(),
                  child: _leaveCard('leaveType', 'date', true));
            }));
  }

  Future<dynamic> requestDetial() {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.5,
        minChildSize: 0.5,
        maxChildSize: 0.8,
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
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sajan Nepali',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                'Senior UI Engineer',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildLeaveInfo('Total Days', '1 days'),
                          _buildLeaveInfo('Leave For', 'Full Day'),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildLeaveInfo('Leave Type', 'Unpaid'),
                          _buildLeaveInfo(
                              'Substitute Personal', 'Romesh Nakarmi'),
                        ],
                      ),
                      const SizedBox(height: 20),
                      _buildLeaveInfo(' date ', 'date'),
                      const SizedBox(height: 15),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Text(
                          'Reason for leave',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Text(
                          ''' An article is a part of speech. In English, there is one definite article: "the." There are two indefinite articles: "a" and "an." The articles refer to a noun. Some examples are: "the house," "a cat," "an activity." ''',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _authority('Aprove'),
                            _authority('reject'),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _authority(String type) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey,
        padding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 60,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () {},
      child: Text(
        type,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _leaveCard(String leaveType, String date, bool approved,
      {bool isPending = false}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  leaveType,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Icon(
              isPending
                  ? Icons.pending
                  : (approved ? Icons.check_circle : Icons.cancel),
              color: isPending
                  ? Colors.grey
                  : (approved ? Colors.green : Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

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
