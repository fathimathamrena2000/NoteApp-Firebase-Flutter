import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_notapp/homepage.dart';
import 'package:firebase_notapp/signup.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  TextEditingController emailcntrlr = TextEditingController();
  TextEditingController psswrdcntrlr = TextEditingController();
  bool? checkBox = false;
  final fireAuth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();

  void loginUser() async {
    try {
      fireAuth.signInWithEmailAndPassword(
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
        //appBar: AppBar(),
        body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      const Text(
        "Sign in",
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                      decoration: const InputDecoration(
                          hintText: "Enter your email:",
                          suffixIcon: Icon(Icons.email_rounded))),
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
                      decoration: const InputDecoration(
                          hintText: "Enter your password:",
                          suffixIcon: Icon(Icons.lock_clock_sharp))),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Checkbox(
                    value: checkBox,
                    onChanged: (val) {
                      setState(() {
                        checkBox = val;
                      });
                    }),
                const Padding(
                  padding: EdgeInsets.only(right: 150),
                  child: Text("Remember me"),
                ),
                const Padding(
                  padding: EdgeInsets.only(),
                  child: Text(
                    "Forgot Password?",
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 150.0),
              child: Container(
                height: 30,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadiusDirectional.circular(10),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      loginUser();
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Page1()));
                    },
                    child: const Text(
                      "Login",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
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
                child: Row(
                  children: [
                    const Text("Don't have an account?"),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Signup()));
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ]));
  }
}
