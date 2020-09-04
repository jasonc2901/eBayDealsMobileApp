import 'package:ebay_deals_app/CustomAlert/AccountCreatedDialog.dart';
import 'package:ebay_deals_app/CustomAlert/InvalidLoginAlert.dart';
import 'package:ebay_deals_app/view/SignUpPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class WelcomePage extends StatefulWidget {
  WelcomePage({Key key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _success;
  String _userEmail;

  resetPageFunction(){
    _emailController.text = "";
    _passwordController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome Page"),
        backgroundColor: Color(0xFF333333),
      ),
      backgroundColor: Color(0xFF333333),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  "Welcome!",
                  style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.w300,
                      color: Colors.white),
                ),
              ),
              SizedBox(height: 50),
              Center(
                child: Text(
                  "Sign In",
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              ),
              SizedBox(height: 30),
              Container(
                width: 300,
                child: TextFormField(
                  controller: _emailController,
                  validator: (val) => val.length < 2 ? 'Still too short' : null,
                  decoration: new InputDecoration(
                    hintText: 'Email Address',
                    hintStyle: TextStyle(color: Colors.white),
                    fillColor: Colors.grey,
                    filled: true,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  style: new TextStyle(
                    fontFamily: "Calibri",
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Container(
                width: 300,
                child: TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  validator: (val) => val.length < 2 ? 'Still too short' : null,
                  decoration: new InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.white),
                    fillColor: Colors.grey,
                    filled: true,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  style: new TextStyle(
                    fontFamily: "Calibri",
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 30),
              RaisedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    _signInWithEmailAndPassword();
                  }
                },
                child: Text('Login'),
              ),
              SizedBox(height: 30),
              FlatButton(
                child: Text(
                  "Need an account? Click here to sign up!",
                  style: TextStyle(fontSize: 20, color: Colors.grey[400]),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpPage()),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signInWithEmailAndPassword() async {
    try {
      final FirebaseUser user = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ))
          .user;

      if (user != null) {
        setState(() {
          _success = true;
          _userEmail = user.email;

          showDialog(
            context: context,
            child: AccountCreatedDialog(
              title: "Welcome back!",
              description: "You are now logged in",
              alertImage: "assets/tick.png",
              buttonText: "Continue",
              buttonColor: Colors.green[400],
              user: user,
            ),
          );

          resetPageFunction();
        });
      } else {
        setState(() {
          _success = false;
        });
      }
    } on Exception catch (exception) {
      print("Exception: $exception");
      showDialog(
          context: context,
          child: InvalidLoginAlert(
            title: "Invalid login details!",
            description: "Please check your details are correct and try again",
            buttonText: "Try again",
            alertImage: "assets/x.png",
            buttonColor: Colors.red[400],
          ));
    }
  }
}
