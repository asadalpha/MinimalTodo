import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:taskapp/UI/Screens/homepage.dart';
import 'package:taskapp/UI/Screens/signup_page.dart.dart';
import '../../Firebase/fire_auth_methods.dart';
import '../../Firebase/firebase_auth_methods.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  Future<void> logInUser() async {
    FirebaseAuthMethods(FirebaseAuth.instance).loginWithEmail(
        email: emailController.text,
        password: passwordController.text,
        context: context);
  }

  AuthClass authClass = AuthClass();

  void googleSignin() {
    FirebaseAuthMethods(FirebaseAuth.instance).signInWithGoogle(context);
    //print("2");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
                height: 260, width: double.infinity, "assets/login.png"),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Welcome Back!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: "Enter your Email",
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 51, 50, 50), width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 133, 101, 178),
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 51, 50, 50), width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 133, 101, 178),
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor:
                            const Color.fromARGB(255, 133, 101, 178),
                      ),
                      onPressed: () {
                        logInUser;
                      },
                      child: const Text(
                        "Log In",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        style:
                            TextButton.styleFrom(foregroundColor: Colors.black),
                        onPressed: () {},
                        child: const Text('Forgot Password?'),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an Account?"),
                      TextButton(
                        style: TextButton.styleFrom(
                            foregroundColor:
                                const Color.fromARGB(255, 133, 101, 178)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpPage()),
                          );
                        },
                        child: const Text('Click Here'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                      ),
                      onPressed: () async {
                        await authClass.googleSignIn(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      },
                      child: const Text(
                        "Sign In with Google",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
