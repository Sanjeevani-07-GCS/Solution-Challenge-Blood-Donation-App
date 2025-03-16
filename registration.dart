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
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.redAccent, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "🩸 Blood Donation App",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 40),
              CustomButton(
                text: "Donor Registration",
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DonorRegistration())),
              ),
              SizedBox(height: 20),
              CustomButton(
                text: "Receiver Registration",
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ReceiverRegistration())),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DonorRegistration extends StatefulWidget {
  @override
  _DonorRegistrationState createState() => _DonorRegistrationState();
}

class _DonorRegistrationState extends State<DonorRegistration> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String? selectedBloodGroup;
  List<String> bloodGroups = ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Donor Registration")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(controller: nameController, label: "Full Name"),
              CustomTextField(controller: emailController, label: "Email", keyboardType: TextInputType.emailAddress),
              CustomTextField(controller: addressController, label: "Address"),
              CustomTextField(controller: phoneController, label: "Phone Number", keyboardType: TextInputType.phone),
              DropdownButtonFormField<String>(
                value: selectedBloodGroup,
                decoration: InputDecoration(labelText: "Select Blood Group", border: OutlineInputBorder()),
                items: bloodGroups.map((String group) {
                  return DropdownMenuItem<String>(
                    value: group,
                    child: Text(group),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedBloodGroup = newValue;
                  });
                },
                validator: (value) => value == null ? "Select Blood Group" : null,
              ),
              SizedBox(height: 20),
              CustomButton(
                text: "Register",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Donor Registered Successfully!")),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom Widgets
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  CustomButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 5,
      ),
      child: Text(text, style: TextStyle(fontSize: 18, color: Colors.white)),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;

  CustomTextField({required this.controller, required this.label, this.keyboardType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
        validator: (value) => value!.isEmpty ? "Enter $label" : null,
      ),
    );
  }
}

class ReceiverRegistration extends StatefulWidget {
  @override
  _ReceiverRegistrationState createState() => _ReceiverRegistrationState();
}

class _ReceiverRegistrationState extends State<ReceiverRegistration> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  bool isOtpSent = false;

  void sendOtp() {
    setState(() {
      isOtpSent = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("OTP Sent to ${phoneController.text}")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Receiver Registration")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(controller: nameController, label: "Full Name"),
              CustomTextField(controller: phoneController, label: "Mobile Number", keyboardType: TextInputType.phone),
              if (isOtpSent)
                CustomTextField(controller: otpController, label: "Enter OTP", keyboardType: TextInputType.number),
              SizedBox(height: 20),
              CustomButton(
                text: isOtpSent ? "Verify OTP & Register" : "Send OTP",
                onPressed: isOtpSent
                    ? () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Receiver Registered Successfully!")),
                          );
                        }
                      }
                    : sendOtp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
