import 'package:flutter/cupertino.dart';
import 'package:jualmotorbekasid/repository/user_repository.dart';
import 'package:provider/provider.dart';

import 'dashboard_screen.dart';
import 'login_screen.dart';
import 'splash_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserRepository.instance(),
      child: Consumer(
        builder: (context, UserRepository user, _) {
          switch (user.status) {
            case Status.Uninitialized:
              return SplashScreen();
            case Status.Unauthenticated:
            case Status.Authenticating:
              return LoginScreen();
            case Status.Authenticated:
              return DashboardScreen(
                user: user.user,
              );
            default:
              return Container();
              break;
          }
        },
      ),
    );
  }
}
