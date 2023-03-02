import 'package:flutter/material.dart';
import 'package:kasarijaane/auth/login.dart';
import 'package:kasarijaane/auth/signin.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image.asset(
            //   'assets/images/logo.png', // own image asset
            //   width: 150,
            // ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
                'Login',
                style: TextStyle(fontSize: 24),
              ),
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupPage()),
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.green, textStyle: TextStyle(fontSize: 18),
              ),
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
