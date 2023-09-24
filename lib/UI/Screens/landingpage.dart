import 'package:flutter/material.dart';
import 'package:taskapp/UI/Screens/login_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Center(
            child: Text(
          "",
          style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 164, 225, 254)),
        )),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(
                height: 300,
                width: double.infinity,
                "assets/purplegirl.png",
                colorBlendMode: BlendMode.multiply,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Welcome to Taskify",
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Making your work easy and enabling you to focus more on your Career",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: Colors.black),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        backgroundColor: const Color.fromARGB(255, 133, 101, 178)),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                    },
                    child: const Text(
                      "Get Started",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
            ),
          ],
        ),
      )),
    );
  }
}
