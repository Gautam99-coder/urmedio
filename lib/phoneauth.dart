import 'package:abc_app/uihelper.dart';
import 'package:flutter/material.dart';

class Phoneauth extends StatefulWidget {
  const Phoneauth({super.key});

  @override
  State<Phoneauth> createState() => _PhoneauthState();
}

class _PhoneauthState extends State<Phoneauth> {
  TextEditingController numbercontroller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phone Auth"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Uihelper.CustomTextField(numbercontroller, "Enter your phone number", Icons.phone, false),
          SizedBox(height:18),
        ],
      ),
    );
  }
}
