# 2310-ICT602
2310-ICT602
Lab Work 2
Login Page
1. Group of 4
2. Using Flutter a framework and Dart as a programming language.
3. Using Android Studio or VS Code to create login page.
4. Run.
5. Make a documentation.


# GROUP:
M3CS2515C
AKMAL FARHAN BIN AHMAD ANNUAR (2022660498)

NURUL IFFAH HASYIMAH BINTI HASAN (2022457982)

ZUHAIRAH NURHIDAYAH BINTI ZAINUDIN (2022457722)

NURFADLIYANA 'AQILAH BINTI SULAIMAN (2022824754)

# LAB 2

Link Youtube : https://youtu.be/ONaUGcHJvNI
```
### Login Page Code Main.dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _errorText;

  void _login() {
    // Perform login logic here (e.g., check credentials)
    // For demonstration purposes, a simple validation is done here
    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() {
        _errorText = 'Please enter both username and password.';
      });
    } else {
      // Reset error text
      setState(() {
        _errorText = null;
      });

      // TODO: Add your login logic here

      // For demonstration purposes, let's print the credentials
      print('Username: ${_usernameController.text}');
      print('Password: ${_passwordController.text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                errorText: _errorText,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                errorText: _errorText,
              ),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
```
