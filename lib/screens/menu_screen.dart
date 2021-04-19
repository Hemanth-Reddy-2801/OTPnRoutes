import 'package:flutter/material.dart';
import 'package:log_in/screens/login_screen.dart';
import 'package:log_in/screens/location_screen.dart';
import 'package:log_in/services/phone_auth.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          MaterialButton(
              child: Row(
                children: [
                  Icon(Icons.logout),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Log Out',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              onPressed: () {
                PhoneAuth().signOut();
                Navigator.pop(context);
                return LogInScreen();
              }),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
