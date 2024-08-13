import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignupPage(),
    );
  }
}

class UserModel {
  String username;
  String email;
  String password;
  String confirmPassword;
  String dob;
  String phoneNumber;
  String panCard;
  String aadhaarCard;
  String hobby;

  UserModel({
    required this.username,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.dob,
    required this.phoneNumber,
    required this.panCard,
    required this.aadhaarCard,
    required this.hobby,
  });
}

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController panCardController = TextEditingController();
  TextEditingController aadhaarCardController = TextEditingController();
  TextEditingController hobbyController = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('DETAILS'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
              obscureText: !_isPasswordVisible,
            ),
            TextField(
              controller: confirmPasswordController,
              decoration: InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
            ),
            TextField(
              controller: dobController,
              decoration: InputDecoration(labelText: 'Date of Birth'),
              keyboardType: TextInputType.datetime,
            ),
            TextField(
              controller: phoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            TextField(
              controller: panCardController,
              decoration: InputDecoration(labelText: 'PAN Card'),
            ),
            TextField(
              controller: aadhaarCardController,
              decoration: InputDecoration(labelText: 'Aadhaar Card'),
            ),
            TextField(
              controller: hobbyController,
              decoration: InputDecoration(
                  labelText: 'Using app as (Uploader / Viewer )'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                UserModel user = UserModel(
                  username: usernameController.text,
                  email: emailController.text,
                  password: passwordController.text,
                  confirmPassword: confirmPasswordController.text,
                  dob: dobController.text,
                  phoneNumber: phoneNumberController.text,
                  panCard: panCardController.text,
                  aadhaarCard: aadhaarCardController.text,
                  hobby: hobbyController.text,
                );
                Navigator.pop(context);
                print('Signup button pressed');
                print('User: $user');
              },
              child: Text('Signup'),
            ),
          ],
        ),
      ),
    );
  }
}
