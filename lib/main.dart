import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(BloodDonationApp());
}

class BloodDonationApp extends StatelessWidget {
  const BloodDonationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.red),
      home: SplashScreen(),
    );
  }
}

// Splash Screen
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              text: "Donor Registration",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DonorRegistrationScreen()),
                );
              },
            ),
            SizedBox(height: 20),
            CustomButton(
              text: "Receiver Registration",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReceiverRegistrationScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Button Widget
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const CustomButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.redAccent,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      ),
      onPressed: onTap,
      child: Text(
        text,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

// Donor Registration
class DonorRegistrationScreen extends StatefulWidget {
  const DonorRegistrationScreen({super.key});

  @override
  _DonorRegistrationScreenState createState() => _DonorRegistrationScreenState();
}

class _DonorRegistrationScreenState extends State<DonorRegistrationScreen> {
  File? _image;
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Donor Registration")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.redAccent,
                backgroundImage: _image != null ? FileImage(_image!) : null,
                child: _image == null ? Icon(Icons.camera_alt, color: Colors.white, size: 40) : null,
              ),
            ),
            SizedBox(height: 20),
            TextField(decoration: InputDecoration(labelText: "Name")),
            TextField(decoration: InputDecoration(labelText: "Blood Group")),
            TextField(decoration: InputDecoration(labelText: "Phone")),
            TextField(decoration: InputDecoration(labelText: "Address")),
            SizedBox(height: 20),
            CustomButton(
              text: "Register",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => DonorProfileScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Donor Profile
class DonorProfileScreen extends StatelessWidget {
  const DonorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Donor Profile")),
      body: Center(child: Text("Donor successfully registered!")),
    );
  }
}

// Receiver Registration
class ReceiverRegistrationScreen extends StatelessWidget {
  const ReceiverRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Receiver Registration")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(decoration: InputDecoration(labelText: "Name")),
            TextField(decoration: InputDecoration(labelText: "Phone")),
            TextField(decoration: InputDecoration(labelText: "OTP")),
            SizedBox(height: 20),
            CustomButton(
              text: "Submit",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => BloodGroupScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Blood Group Selection
class BloodGroupScreen extends StatelessWidget {
  static const List<String> bloodGroups = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];


  const BloodGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Blood Group")),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: bloodGroups.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => DonorListScreen(bloodGroup: bloodGroups[index])));
            },
            child: Card(
              color: Colors.white,
              child: Center(child: Text(bloodGroups[index], style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red))),
            ),
          );
        },
      ),
    );
  }
}

// Donor List
class DonorListScreen extends StatelessWidget {
  final String bloodGroup;
  DonorListScreen({super.key, required this.bloodGroup});

  final List<Map<String, String>> donors = List.generate(5, (index) => {
    'name': 'Donor ${index + 1}',
    'phone': '123-456-789$index',
    'address': 'City ${index + 1}',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Donors of $bloodGroup")),
      body: ListView.builder(
        itemCount: donors.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(donors[index]['name']!),
            subtitle: Text("📞 ${donors[index]['phone']} \n📍 ${donors[index]['address']}"),
          );
        },
      ),
    );
  }
}