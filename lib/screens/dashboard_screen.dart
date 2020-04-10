import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jualmotorbekasid/repository/user_repository.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  final FirebaseUser user;

  const DashboardScreen({Key key, this.user}) :super(key:key);

  @override
  Widget build(BuildContext context) {

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Dashboad'),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(user.email),
            CupertinoButton.filled(

              child: Text('Sign Out'),
              onPressed: () => Provider.of<UserRepository>(context).signOut(),
            )
          ],
        ),
      ),
    );
  }
}
