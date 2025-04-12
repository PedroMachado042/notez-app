import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
    required this.title,
    required this.button_text,
  });
  final String title;
  final String button_text;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(widget.title, style: TextStyle(fontSize: 30)),
            ),
            SizedBox(height: 40),
            SizedBox(width: double.infinity, child: Text('E-mail')),
            TextField(),
            SizedBox(height: 20),
            SizedBox(width: double.infinity, child: Text('Password')),
            TextField(),
            SizedBox(height: 60),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  widget.button_text,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
