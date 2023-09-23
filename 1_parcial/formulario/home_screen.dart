import 'package:flutter/material.dart';


class LandingPage extends StatefulWidget {
  LandingPage({super.key, required this.userName, required this.userLast, 
  required this.userPlast, required this.userPhone, required this.userEmail, 
  required this.userAge});

  final String userName;
  final String userLast;
  final String userPlast;
  final String userPhone;
  final String userEmail;
  final String userAge;

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: const Text("Landing Page",
            style: TextStyle(color: Color.fromARGB(255, 5, 5, 5))),
            centerTitle: true,
            backgroundColor: Color.fromARGB(31, 5, 3, 3),
          ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 50,
          ),
          const Center(
            child: Text(
              "Landing Page",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black54),
            )),
          const SizedBox(
            height: 50,
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
              '''
                 Bienvenido: ${widget.userName} ${widget.userLast} ${widget.userPlast} 
                 Telefono: ${widget.userPhone} 
                 Email: ${widget.userEmail} 
                 Edad: ${widget.userAge}''',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 92, 64, 251)),
              ),
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Logout"),
          )),
            ],
      ),
    );
  }
}
