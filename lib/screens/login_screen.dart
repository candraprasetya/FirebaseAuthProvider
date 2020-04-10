import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jualmotorbekasid/repository/user_repository.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextEditingController _email;
  TextEditingController _password;
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _email = TextEditingController(text: "");
    _password = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserRepository>(context);

    return CupertinoPageScaffold(
      key: _key,
      navigationBar: CupertinoNavigationBar(
        middle: Text('Login'),
      ),
      child: Form(
        key: _formKey,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: CupertinoTextField(
                  controller: _email,
                  placeholder: 'Enter Email',
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: CupertinoTextField(
                  controller: _password,
                  placeholder: 'Enter Password',
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                ),
              ),
              user.status == Status.Authenticating
                  ? Center(
                      child: CupertinoActivityIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: CupertinoButton.filled(
                          child: Text('Sign In'),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              if (!await user.signIn(
                                  _email.text, _password.text))
                                showCupertinoDialog(
                                    context: context,
                                    builder: (context) => CupertinoAlertDialog(
                                          insetAnimationCurve:
                                              Curves.easeInOutQuart,
                                          title: Text("Warning"),
                                          content:
                                              Text("There is something wrong"),
                                    actions: <Widget>[
                                      CupertinoDialogAction(
                                        child: Text('Dismiss'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                    )

                                );

                            }
                          }),
                    )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
}
