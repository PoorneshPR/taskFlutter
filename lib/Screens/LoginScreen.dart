import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_flutter/Services/Provider/LoginProvider.dart';
import 'package:task_flutter/Services/Routes/RoutesUtils.dart';
import 'package:task_flutter/screens/HomeScreen.dart';
import '../Services/Provider/AuthenticationProvider.dart';
import '../Services/Provider/UtilityProvider.dart';
import '../generated/l10n.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);
  String emailValue = "";
  String pwdValue = "";
  String userNameValue = "";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  LoginProvider loginProviderValue = LoginProvider();
  Map? fBInDetails;
  bool _loginStatus = false;

  controllerClear() {
    emailController.clear();
    pwdController.clear();
    userNameController.clear();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final translated = S.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        titleSpacing: 2,
        title: const Text("Login", style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white60,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        hintText: translated.name,
                        labelText: translated.name,
                        suffixIcon: const Icon(Icons.person_outline),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black87),
                          borderRadius: BorderRadius.circular(20.0),
                        )),
                    controller: userNameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter your name";
                      } else {
                        return null;
                      }
                    }),
              ),
              Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        suffixIcon: const Icon(Icons.email_outlined),
                        hintText: translated.emailAddress,
                        labelText: translated.emailAddress,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black87),
                          borderRadius: BorderRadius.circular(20.0),
                        )),
                    controller: emailController,
                    validator: LoginProvider().validateEmailStructure,
                  )),
              Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextFormField(
                    obscureText: true,
                    controller: pwdController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        suffixIcon: const Icon(Icons.lock_outline),
                        hintText: translated.password,
                        labelText: translated.password,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black87),
                          borderRadius: BorderRadius.circular(20.0),
                        )),
                    validator: LoginProvider().validatePwdStructure,
                  )),
              Padding(
                padding: const EdgeInsets.all(15),
                child: SizedBox(
                  width: double.maxFinite,
                  height: MediaQuery.of(context).size.height * 0.080,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        widget.emailValue = emailController.value.text;
                        widget.pwdValue = pwdController.value.text;
                        widget.userNameValue = userNameController.value.text;

                        context
                            .read<LoginProvider>()
                            .signInUser(widget.emailValue, widget.pwdValue,
                            widget.userNameValue, context)
                            .then((value) {
                          _loginStatus = true;

                          context
                              .read<LoginProvider>()
                              .userSetLoginCheck(_loginStatus);
                          UtilityProvider()
                              .setStringToUserName(widget.userNameValue);

                          RoutesUtils.navToHome(context);
                          controllerClear();
                        });
                      }
                    },
                    child: const Text("Submit"),
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ),
              ),
              FutureBuilder(
                  future: AuthenticationProvider().initializeFirebase(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text(
                          "error in initializing the fire base app");
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      return OutlinedButton(
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            await context
                                .read<AuthenticationProvider>()
                                .signInGoogle(context)
                                .then((value) async {
                              if (value != null) {
                                _loginStatus = true;
                                UtilityProvider().setStringToUserName(context
                                    .read<AuthenticationProvider>()
                                    .userdetails
                                    .toString());

                                context
                                    .read<LoginProvider>()
                                    .userSetLoginCheck(_loginStatus);

                                RoutesUtils.navToHome(context);
                              }
                            });
                          },
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    const Image(
                                      image:
                                      AssetImage("assets/Google_Logo.png"),
                                      height: 23.0,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(
                                        translated.loginWithGoogle,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )
                                  ])));
                    }
                    return const CircularProgressIndicator(
                      strokeWidth: 5,
                      backgroundColor: Colors.blue,
                    );
                  }),
              Padding(
                padding: const EdgeInsets.all(15),
                child: OutlinedButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    onPressed: () async {
                      context
                          .read<AuthenticationProvider>()
                          .signInFacebook(context)
                          .then((value) {
                        if (value != null) {
                          setState(() {
                            _loginStatus = true;
                          });
                          context
                              .read<LoginProvider>()
                              .userSetLoginCheck(_loginStatus);
                          fBInDetails = value;

                          context
                              .read<LoginProvider>()
                              .userSetLoginCheck(_loginStatus);
                          UtilityProvider().setStringToUserName(context
                              .read<LoginProvider>()
                              .userSetLoginCheck(_loginStatus)
                              .toString());

                          RoutesUtils.navToHome(context);

                        }
                      });
                    },
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Image(
                                image: AssetImage("assets/fb_logo.jpg"),
                                height: 23.0,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  translated.loginWithFacebook,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            ]))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
