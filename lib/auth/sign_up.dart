import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/auth/sign_in.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //! Keys
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  ///! TextEditing Controller
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  // show/hide password
  bool isSelectionOn = true;

  // @override
  // void initState() {
  //   email = TextEditingController();
  //   password = TextEditingController();
  //   super.initState();
  // }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  //! Firebase Auth Instance
  final FirebaseAuth fireBaseInstance = FirebaseAuth.instance;
  Future<void> createUser(String email, String password) async {
    try {
      await fireBaseInstance.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print(e);
    }
    print("Created User Successfully");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        centerTitle: true,
      ),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 16, bottom: 20, left: 8),
                child: Text(
                  "Register for an account",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                validator: (err) {
                  if (email.text.isEmpty) {
                    return "Enter a valid email";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  label: const Text("Email"),
                  filled: true,
                  // fillColor: Colors.blue.shade50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: password,
                obscureText: isSelectionOn,
                validator: (err) {
                  if (password.text.isEmpty) {
                    return "Password cannot be empty";
                  } else if (password.text.length < 6) {
                    return "Password is too short";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    label: const Text("Password"),
                    filled: true,
                    // fillColor: Colors.blue.shade50,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isSelectionOn = !isSelectionOn;
                        });
                      },
                      icon: Icon(
                        isSelectionOn ? Icons.visibility_off : Icons.visibility,
                        color: Colors.black,
                      ),
                    )),
              ),
              const SizedBox(
                height: 30,
              ),
              // TextButton(onPressed: () {}, child: Text("Submit")),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: TextButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.amber),
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        createUser(email.text, password.text);
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const LoginScreen()));
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => const Text("Incorrect Details"),
                        );
                      }
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => const LoginScreen()),
                      );
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.amber),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
