import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class UpdateScreen extends StatefulWidget {
  final String data;
  // ignore: use_key_in_widget_constructors
  const UpdateScreen({required this.data});
  @override
  // ignore: library_private_types_in_public_api
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  // ignore: prefer_final_fields
  TextEditingController _textController = TextEditingController();

  void _showSuccessfulMessage(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Text("From StartupProjects"),
              content: Text(msg),
              actions: <Widget>[
                // ignore: deprecated_member_use
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()));
                    },
                    child: const Text("okay"))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Task"),
      ),
      body: Center(
        child: Column(
          children: [
            TextFormField(
              controller: _textController,
              decoration: const InputDecoration(hintText: "Enter Updated Task"),
            ),
            const SizedBox(
              height: 10,
            ),
            // ignore: deprecated_member_use
            ElevatedButton(
                onPressed: () {
                  String message = "data updated successfully";
                  FirebaseFirestore.instance
                      .collection("Tasks")
                      .where("data", isEqualTo: widget.data)
                      .get()
                      .then(
                        (snapshot) => snapshot.docs.first.reference
                            .update({"data": _textController.text}),
                      );
                  _showSuccessfulMessage(message);
                },
                child: const Text("Update"))
          ],
        ),
      ),
    );
  }
}
