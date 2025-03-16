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
      home: DonorProfileScreen(),
    );
  }
}

class DonorProfileScreen extends StatefulWidget {
  @override
  _DonorProfileScreenState createState() => _DonorProfileScreenState();
}

class _DonorProfileScreenState extends State<DonorProfileScreen> {
  String profileImage = "https://cdn-icons-png.flaticon.com/512/149/149071.png";
  String name = "John Doe";
  String phone = "123-456-7890";
  String email = "john.doe@example.com";
  String address = "123 Street, City";
  String bloodGroup = "A+";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Donor Profile", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        elevation: 5,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // Profile Picture with Shadow and Camera Button
            Stack(
              children: [
                CircleAvatar(
                  radius: 65,
                  backgroundColor: Colors.redAccent,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(profileImage),
                    backgroundColor: Colors.grey[300],
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: GestureDetector(
                    onTap: () {
                      print("Change Profile Picture");
                    },
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.camera_alt, color: Colors.redAccent, size: 22),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Profile Details
            ProfileDetailRow(icon: Icons.person, label: "Name", value: name),
            ProfileDetailRow(icon: Icons.phone, label: "Phone", value: phone),
            ProfileDetailRow(icon: Icons.email, label: "Email", value: email),
            ProfileDetailRow(icon: Icons.location_on, label: "Address", value: address),
            ProfileDetailRow(icon: Icons.bloodtype, label: "Blood Group", value: bloodGroup),
            SizedBox(height: 25),
            // Edit Profile Button
            ElevatedButton(
              onPressed: () async {
                final updatedInfo = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfileScreen(name, phone, email, address, bloodGroup),
                  ),
                );

                if (updatedInfo != null) {
                  setState(() {
                    name = updatedInfo["name"];
                    phone = updatedInfo["phone"];
                    email = updatedInfo["email"];
                    address = updatedInfo["address"];
                    bloodGroup = updatedInfo["bloodGroup"];
                  });
                }
              },
              child: Text("Edit Profile", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileDetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  ProfileDetailRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
        child: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.redAccent.shade100,
              child: Icon(icon, color: Colors.white, size: 22),
            ),
            SizedBox(width: 15),
            Text("$label:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Spacer(),
            Text(value, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class EditProfileScreen extends StatefulWidget {
  final String name;
  final String phone;
  final String email;
  final String address;
  final String bloodGroup;

  EditProfileScreen(this.name, this.phone, this.email, this.address, this.bloodGroup);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController addressController;
  String selectedBloodGroup = "A+";

  final List<String> bloodGroups = ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"];

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    phoneController = TextEditingController(text: widget.phone);
    emailController = TextEditingController(text: widget.email);
    addressController = TextEditingController(text: widget.address);
    selectedBloodGroup = widget.bloodGroup;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Edit Profile", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CustomTextField(controller: nameController, label: "Full Name"),
            CustomTextField(controller: phoneController, label: "Phone Number"),
            CustomTextField(controller: emailController, label: "Email"),
            CustomTextField(controller: addressController, label: "Address"),
            SizedBox(height: 10),
            DropdownButtonFormField(
              value: selectedBloodGroup,
              items: bloodGroups.map((group) {
                return DropdownMenuItem(value: group, child: Text(group));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedBloodGroup = value.toString();
                });
              },
              decoration: InputDecoration(
                labelText: "Blood Group",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              ),
            ),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  "name": nameController.text,
                  "phone": phoneController.text,
                  "email": emailController.text,
                  "address": addressController.text,
                  "bloodGroup": selectedBloodGroup,
                });
              },
              child: Text("Save Changes", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  CustomTextField({required this.controller, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        ),
      ),
    );
  }
}
