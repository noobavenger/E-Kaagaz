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

enum UserType { uploader, viewer }

class UserModel {
  String username;
  String email;
  String password;
  String confirmPassword;
  String dob;
  String phoneNumber;
  String panCard;
  String aadhaarCard;
  UserType userType;

  UserModel({
    required this.username,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.dob,
    required this.phoneNumber,
    required this.panCard,
    required this.aadhaarCard,
    required this.userType,
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
  UserType? _selectedUserType;
  bool _isPasswordVisible = false;

  // Validate whether the required fields are not empty
  bool isRequiredFieldsValid() {
    return usernameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        dobController.text.isNotEmpty &&
        phoneNumberController.text.isNotEmpty &&
        panCardController.text.isNotEmpty &&
        aadhaarCardController.text.isNotEmpty;
  }

  // Validate whether password and confirm password match
  bool isPasswordMatching() {
    return passwordController.text == confirmPasswordController.text;
  }

  // Validate email using a regular expression
  bool isEmailValid(String email) {
    String emailPattern =
        r'^[\w-]+(\.[\w-]+)*@([a-z0-9-]+(\.[a-z0-9-]+)*?\.[a-z]{2,}|(\d{1,3}\.){3}\d{1,3})$';
    RegExp regex = RegExp(emailPattern);
    return regex.hasMatch(email);
  }

  // Validate whether the phone number has exactly 10 digits
  bool isPhoneNumberValid(String phoneNumber) {
    return phoneNumber.length == 10;
  }

  // Validate PAN card using a regular expression
  bool isPanCardValid(String panCard) {
    String panCardPattern = r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$';
    RegExp regex = RegExp(panCardPattern);
    return regex.hasMatch(panCard);
  }

  // Validate Aadhaar card using a regular expression
  bool isAadhaarCardValid(String aadhaarCard) {
    String aadhaarCardPattern = r'^[2-9]{1}[0-9]{3}[0-9]{4}[0-9]{4}$';
    RegExp regex = RegExp(aadhaarCardPattern);
    return regex.hasMatch(aadhaarCard);
  }

  // Show date picker
  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != DateTime.now()) {
      setState(() {
        dobController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

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
              decoration: InputDecoration(labelText: 'Username*'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email*'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password*',
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
              decoration: InputDecoration(labelText: 'Confirm Password*'),
              obscureText: true,
            ),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: TextField(
                  controller: dobController,
                  decoration: InputDecoration(labelText: 'Date of Birth*'),
                ),
              ),
            ),
            TextField(
              controller: phoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number*'),
              keyboardType: TextInputType.phone,
              onChanged: (String value) {
                // Check if the entered phone number has exactly 10 digits
                if (!isPhoneNumberValid(value)) {
                  // You can show an error message or take appropriate action
                  print('Invalid phone number. Please enter 10 digits.');
                }
              },
            ),
            TextField(
              controller: panCardController,
              decoration: InputDecoration(labelText: 'PAN Card*'),
              // Automatically convert text to uppercase
              onChanged: (String value) {
                setState(() {
                  panCardController.text = value.toUpperCase();
                  panCardController.selection = TextSelection.fromPosition(
                      TextPosition(offset: panCardController.text.length));
                });
              },
            ),
            TextField(
              controller: aadhaarCardController,
              decoration: InputDecoration(labelText: 'Aadhaar Card*'),
            ),
            SizedBox(height: 20.0),
            Text(
              'Using app as*',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: const Text('Uploader'),
              leading: Radio(
                value: UserType.uploader,
                groupValue: _selectedUserType,
                onChanged: (UserType? value) {
                  setState(() {
                    _selectedUserType = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Viewer'),
              leading: Radio(
                value: UserType.viewer,
                groupValue: _selectedUserType,
                onChanged: (UserType? value) {
                  setState(() {
                    _selectedUserType = value;
                  });
                },
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                if (isRequiredFieldsValid() &&
                    isPasswordMatching() &&
                    isEmailValid(emailController.text) &&
                    isPhoneNumberValid(phoneNumberController.text) &&
                    isPanCardValid(panCardController.text) &&
                    isAadhaarCardValid(aadhaarCardController.text)) {
                  UserModel user = UserModel(
                    username: usernameController.text,
                    email: emailController.text,
                    password: passwordController.text,
                    confirmPassword: confirmPasswordController.text,
                    dob: dobController.text,
                    phoneNumber: phoneNumberController.text,
                    panCard: panCardController.text,
                    aadhaarCard: aadhaarCardController.text,
                    userType: _selectedUserType ?? UserType.uploader,
                  );
                  Navigator.pop(context);
                  print('Signup button pressed');
                  print('User: $user');
                } else {
                  String errorMessage;
                  if (!isRequiredFieldsValid()) {
                    errorMessage =
                        'All fields are mandatory. Please fill in all required fields.';
                  } else if (!isEmailValid(emailController.text)) {
                    errorMessage = 'Invalid email format.';
                  } else if (!isPhoneNumberValid(phoneNumberController.text)) {
                    errorMessage =
                        'Invalid phone number. Please enter 10 digits.';
                  } else if (!isPanCardValid(panCardController.text)) {
                    errorMessage = 'Invalid PAN card format.';
                  } else if (!isAadhaarCardValid(aadhaarCardController.text)) {
                    errorMessage = 'Invalid Aadhaar card format.';
                  } else {
                    errorMessage =
                        'Password and Confirm Password do not match.';
                  }
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error'),
                        content: Text(errorMessage),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Signup'),
            ),
          ],
        ),
      ),
    );
  }
}
