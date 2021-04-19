import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:log_in/main.dart';
import 'package:log_in/screens/login_screen.dart';

class RouteBasedOnAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return CircularProgressIndicator();
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data != null)
              return HomePage();
            else
              return LogInScreen();
          }
          return CircularProgressIndicator();
        });
  }
}
