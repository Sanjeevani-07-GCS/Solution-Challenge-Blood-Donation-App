import 'package:flutter/material.dart';

void main() {
  runApp(BloodDonationApp());
}

class BloodDonationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.red),
      home: BloodGroupScreen(),
    );
  }
}

class BloodGroupScreen extends StatelessWidget {
  final List<String> bloodGroups = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Blood Group"),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        elevation: 5,
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.2,
          ),
          itemCount: bloodGroups.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DonorListScreen(bloodGroup: bloodGroups[index]),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 6,
                shadowColor: Colors.black45,
                color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.bloodtype, size: 35, color: Colors.redAccent),
                      SizedBox(height: 8),
                      Text(
                        bloodGroups[index],
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class DonorListScreen extends StatelessWidget {
  final String bloodGroup;

  DonorListScreen({required this.bloodGroup});

  final List<Map<String, String>> donors = List.generate(5, (index) => {
    'name': 'Donor ${index + 1}',
    'phone': '123-456-789${index}',
    'email': 'donor${index + 1}@mail.com',
    'address': 'City ${index + 1}',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Donors of $bloodGroup"),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        elevation: 5,
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: ListView.builder(
          itemCount: donors.length,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 5,
              shadowColor: Colors.black38,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                contentPadding: EdgeInsets.all(12),
                leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.redAccent.shade100,
                  child: Icon(Icons.person, color: Colors.white, size: 30),
                ),
                title: Text(
                  donors[index]['name']!,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("📞 ${donors[index]['phone']}", style: TextStyle(fontSize: 14)),
                      Text("✉ ${donors[index]['email']}", style: TextStyle(fontSize: 14)),
                      Text("📍 ${donors[index]['address']}", style: TextStyle(fontSize: 14)),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
