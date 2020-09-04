import 'dart:io';
import 'package:ebay_deals_app/CustomAlert/AccountCreatedDialog.dart';
import 'package:ebay_deals_app/CustomAlert/CustomAlert.dart';
import 'package:ebay_deals_app/CustomAlert/InvalidLoginAlert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:email_validator/email_validator.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _displayNameController = new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _success;
  String _userEmail;
  File _image;
  String imageSelectBtnText = "Select Image";

  //change text color when image is selected
  bool styleOBJ = true;
  changeStyle(){
    setState(() {
     styleOBJ = false ;
    });
  }
  
  // the functions to handle the disable button click events
  bool isEnabled = true;
  disableButton() {
    setState(() {
      isEnabled = false;
      imageSelectBtnText = "Image selected!";
    });
  }

  //re enable the button when page is reset
  enableButton() {
    setState(() {
      isEnabled = true;
      imageSelectBtnText = "Select Image";
    });
  }

  imageFunction() async {
    pickImageFromGallery();
  }

  resetPageFunction() {
    _emailController.text = "";
    _passwordController.text = "";
    _displayNameController.text = "";
    enableButton();
    _image = null;
  }

  Future pickImageFromGallery() async {
    var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = imageFile;
    });

    //disables the button only once the image has been selected
    if (imageFile != null) {
      showDialog(
        context: context,
        child: CustomDialog(
            title: "Image Uploaded!",
            description: "You have added a profile image",
            buttonText: "Continue",
            alertImage: "assets/tick.png",
            buttonColor: Colors.green[400]),
      );
      disableButton();
      changeStyle();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign up page"),
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
                  "Sign Up",
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              ),
              SizedBox(height: 30),
              Container(
                width: 300,
                child: TextFormField(
                  controller: _displayNameController,
                  validator: (val) =>
                      val.length < 6 ? 'Must be at least 6 characters!' : null,
                  decoration: new InputDecoration(
                    errorStyle: TextStyle(fontSize: 20.0),
                    hintText: 'Display Name',
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
                  controller: _emailController,
                  validator: (val) => EmailValidator.validate(val) == false
                      ? 'Invalid Email Format'
                      : null,
                  decoration: new InputDecoration(
                    errorStyle: TextStyle(fontSize: 20.0),
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
                  validator: (val) =>
                      val.length < 8 ? 'Must be 8 characters or more!' : null,
                  decoration: new InputDecoration(
                    errorStyle: TextStyle(fontSize: 20.0),
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
              Center(
                child: CircleAvatar(
                  backgroundColor: Colors.grey[400],
                  radius: 50,
                  backgroundImage: _image != null ? FileImage(_image) : null,
                ),
              ),
              SizedBox(height: 30),
              Text(
                "Choose a profile image:",
                style: styleOBJ ? 
                  TextStyle(fontSize: 24, color: Colors.white)
                  :
                  TextStyle(fontSize: 24, color: Colors.grey),
              ),
              SizedBox(height: 15),
              RaisedButton(
                onPressed: isEnabled ? () => imageFunction() : null,
                child: Text(
                  imageSelectBtnText,
                  textAlign: TextAlign.left,
                ),
                disabledColor: Colors.grey[700],
                disabledTextColor: Colors.grey,
              ),
              SizedBox(height: 60),
              Container(
                width: 200,
                height: 60,
                child: RaisedButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      _register();
                    }
                  },
                  child: Text('Sign Up'),
                ),
              ),
              SizedBox(height: 30)
            ],
          ),
        ),
      ),
    );
  }

  void _register() async {
    if (_image != null) {
      try {
        FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        ))
            .user;

        UserUpdateInfo newFirebaseInfo = new UserUpdateInfo();

        newFirebaseInfo.displayName = _displayNameController.text;
        newFirebaseInfo.photoUrl = _image.path;
        await user.updateProfile(newFirebaseInfo);
        await user.reload();

        user = await _auth.currentUser();

        if (user != null) {
          setState(() {
            _success = true;
            _userEmail = user.email;

            showDialog(
              context: context,
              child: AccountCreatedDialog(
                title: "Success",
                description: "Your account has been created!",
                alertImage: "assets/tick.png",
                buttonText: "Continue",
                buttonColor: Colors.green[400],
                user: user,
              ),
            );
            //resets the values on the page
            resetPageFunction();
          });
        } else {
          setState(() {
            _success = false;
          });
        }
      } on Exception catch (exception) {
        if (exception.toString().contains("ERROR_EMAIL_ALREADY_IN_USE")) {
          showDialog(
              context: context,
              child: InvalidLoginAlert(
                  title: "Email already registered!",
                  description:
                      "An existing account with the same email already exists.",
                  buttonText: "Try Again",
                  alertImage: "assets/x.png",
                  buttonColor: Colors.red[400]));
        }
      }
    } else {
      showDialog(
          context: context,
          child: InvalidLoginAlert(
              title: "No Profile Pic!",
              description: "You must upload a profile picture!",
              buttonText: "Try again",
              alertImage: "assets/x.png",
              buttonColor: Colors.red[400]));
    }
  }
}
