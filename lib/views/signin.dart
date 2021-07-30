import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizmaker/models/my_user.dart';
import 'package:quizmaker/services/auth.dart';
import 'package:quizmaker/views/home.dart';
import 'package:quizmaker/views/signup.dart';
import 'package:quizmaker/widgets/widgets.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  late String email, password;
  AuthService authService = AuthService();

  bool _isLoading = false;
  String _signInError = "";

  signIn() async {
    _signInError = "";
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      await authService.signInEmailAndPass(email, password).then((val) {
        setState(() {
          _isLoading = false;
        });
        if (val != null) {
          if (val.runtimeType == MyUser) {
            /* This is a valid Firebase user */
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => const Home()));
          } else {
            /* an error has occurred (type String) */
            setState(() {
              _signInError = val;
            });
          }
        } else {
          setState(() {
            _signInError =
                "Unexpected error occurred (Empty response from the server)";
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0, // Or the appbar will be ugly grey,
        brightness: Brightness.light, // To show status bar properly
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    /// Take as much needed space before the rest of columns
                    const Spacer(),

                    /// Input Email
                    TextFormField(
                      validator: (val) {
                        return val!.isEmpty ? "Enter Email" : null;
                      },
                      decoration: const InputDecoration(hintText: "Email"),
                      onChanged: (val) {
                        email = val;
                      },
                    ),

                    /// Margin space
                    const SizedBox(
                      height: 6,
                    ),

                    /// Input password
                    TextFormField(
                      obscureText: true,
                      validator: (val) {
                        return val!.isEmpty ? "Enter password" : null;
                      },
                      decoration: const InputDecoration(hintText: "Password"),
                      onChanged: (val) {
                        password = val;
                      },
                    ),

                    /// Margin space
                    const SizedBox(
                      height: 24,
                    ),

                    /// Error container
                    Container(
                      padding: const EdgeInsets.only(bottom: 10),
                      alignment: Alignment.center,
                      child: _signInError.isNotEmpty
                          ? Text(
                              _signInError,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 16),
                            )
                          : const SizedBox(
                              height: 0,
                            ),
                    ),

                    /// The button
                    GestureDetector(
                      onTap: () {
                        signIn();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(30)),
                        alignment: Alignment.center,

                        /// We should use width or the container width will take the width of it's child
                        width: MediaQuery.of(context).size.width - 48,
                        child: const Text(
                          "Sign in",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),

                    /// Margin space
                    const SizedBox(
                      height: 18,
                    ),

                    /// Don't have an account? Sign up
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(fontSize: 15.5),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUp()));
                          },
                          child: const Text("Sign up",
                              style: TextStyle(
                                  fontSize: 15.5,
                                  decoration: TextDecoration.underline)),
                        ),
                      ],
                    ),

                    /// Last margin space
                    const SizedBox(
                      height: 80,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
