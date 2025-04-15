import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notez/view/pages/login_page.dart';

class GuestPage extends StatelessWidget {
  const GuestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          Text(
            'Welcome to Notez!',
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
            textAlign: TextAlign.center,
          ),
          Divider(color: Colors.grey[700]),
          SizedBox(
            width: 150,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => LoginPage(isRegistring: false),
                  ),
                );
              },
              child: Text(
                'Login',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black.withAlpha(40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ),

          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => LoginPage(isRegistring: true),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black.withAlpha(40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              child: Text(
                'Register',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
          Divider(color: Colors.grey[700]),
          IconButton(
            onPressed: () {
              Fluttertoast.showToast(
                msg: 'Function not added yet :(',
                backgroundColor: Colors.black87,
              );
            },
            icon: Image.asset(
              'assets/images/google_logo.png',
              height: 25,
            ),
          ),
          SizedBox(height: 100),
        ],
      ),
    );
  }
}
