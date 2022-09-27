// ignore_for_file: prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase_new/screens/retrieve_data.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _taskController = TextEditingController();
  void _showSuccessfulMessage(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Text("Alert"),
              content: Text(msg),
              actions: <Widget>[
                // ignore: deprecated_member_use
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("okay"))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firestore Crud"),
      ),
      body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    controller: _taskController,
                    decoration: const InputDecoration(hintText: "Enter Task"),
                    validator: (String? value) {
                      if (value != null && value.isEmpty) {
                        return "Enter Task";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                // ignore: deprecated_member_use
                ElevatedButton(
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      _formKey.currentState!.save();
                      String message = "Task added successfully";
                      Map<String, dynamic> data = {
                        "data": _taskController.text
                      };
                      FirebaseFirestore.instance
                          .collection("Tasks")
                          .add(data)
                          .then((value) => _showSuccessfulMessage(message));
                    },
                    child: const Text("Submit")),
                const SizedBox(
                  height: 13,
                ),
                // ignore: deprecated_member_use
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RetrieveData()));
                    },
                    child: const Text("View Task"))
              ],
            ),
          )),
    );
  }
}
