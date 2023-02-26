import 'package:flutter/material.dart';
import 'package:kasarijaane/auth/login.dart';
import '../components/constants.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  late String _email, _password;

  String _selectedVehicleType = 'Bus';
  String _selectedVehicleId = '011';

  final _vehicleIdController = TextEditingController();
  final _startingPointController = TextEditingController();
  final _destinationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 80.0),
            //TODO : add logo and name here
            SizedBox(height: 120.0),
            // Email
            TextFormField(
              decoration: InputDecoration(labelText: "Email"),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter your email.";
                }
                return null;
              },
              onSaved: (value) => _email = value!,
            ),
            SizedBox(height: 12.0),
            // Password
            TextFormField(
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter your password.";
                }
                return null;
              },
              onSaved: (value) => _password = value!,
            ),
            SizedBox(height: 24.0),
            Row(
              children: [
                Text('Type'),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: kblack,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: DropdownButton<String>(
                      focusColor: kwhite,
                      value: _selectedVehicleType,
                      alignment: Alignment.centerRight,
                      items: ['Bus', 'Tempo', 'Micro']
                          .map((type) => DropdownMenuItem(
                                child: Text(type),
                                value: type,
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedVehicleType = value!;
                        });
                      },
                      underline: Container(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.0),
            Row(
              children: [
                Text('Id'),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: kblack,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: DropdownButton<String>(
                      focusColor: kwhite,
                      value: _selectedVehicleId,
                      alignment: Alignment.centerRight,
                      items: ['011', '012', '051']
                          .map((type) => DropdownMenuItem(
                                child: Text(_selectedVehicleId),
                                value: type,
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedVehicleId = value!;
                        });
                      },
                      underline: Container(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.0),
            // Sign up button
            ElevatedButton(
              child: Text("Sign Up"),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState?.save();
                  // Perform authentication and save the user data
                }
              },
            ),
            SizedBox(height: 18.0),
            // Login link
            TextButton(
              child: Text("Already have an account? Login"),
              onPressed: () {
                // Navigate to the login page
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
