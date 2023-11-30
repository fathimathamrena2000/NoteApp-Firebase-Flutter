import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_notapp/loginscreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController emailcntrlr = TextEditingController();
  TextEditingController psswrdcntrlr = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool? checkBox = false;
  final fireAuth = FirebaseAuth.instance;
  void createuser() async {
    try {
      fireAuth.createUserWithEmailAndPassword(
          email: emailcntrlr.text, password: psswrdcntrlr.text);
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  void dispose() {
    emailcntrlr.dispose();
    psswrdcntrlr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
          const Text(
            "Sign Up",
            style: TextStyle(
              color: Colors.black,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 80,
          ),
          Form(
            key: _formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "E-mail",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 2)),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.green[70],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: emailcntrlr,
                      validator: (value) {
                        final isValid =
                            EmailValidator.validate(value.toString());
                        return isValid ? null : "Email is not valid";
                      },
                      decoration:
                          const InputDecoration(hintText: "Enter your email"),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Password",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.green[70],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        controller: psswrdcntrlr,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "password is required";
                          }
                          if (value.length < 8) {
                            return "Password must be at least 8 characters long";
                          }
                          if (!value.contains(RegExp(r'[A-Z]'))) {
                            return "Password must contain at least one uppercase letter";
                          }
                          if (!value.contains(RegExp(r'[a-z]'))) {
                            return "Password must contain at least one lowercase letter";
                          }
                          if (!value.contains(RegExp(r'[0-9]'))) {
                            return "Password must contain at least one numeric character";
                          }
                          if (!value
                              .contains(RegExp(r'[!@#\$%^&*()<>?/|}{~:]'))) {
                            return "Password must contain at least one special character";
                          }

                          return null;
                        },
                        decoration: const InputDecoration(
                            hintText: "Enter your password")),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 150.0),
                child: Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadiusDirectional.circular(10),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        //
                      },
                      child: InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            createuser();
                          }
                        },
                        child: const Text(
                          "Submit",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 100.0),
                child: SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Row(children: [
                    const Text(" Already have an account?"),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Loginpage()));
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ),

                    //                    ],
                  ]),
                ),
              ),
            ]),
          )
        ]));
  }
}
