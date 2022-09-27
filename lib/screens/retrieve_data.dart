import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase_new/screens/update_screen.dart';
import 'package:flutter/material.dart';

class RetrieveData extends StatefulWidget {
  const RetrieveData({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RetrieveDataState createState() => _RetrieveDataState();
}

class _RetrieveDataState extends State<RetrieveData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Tasks"),
      ),
      body: StreamBuilder(
        //StreamBuilder is used to convert object to Widget
        stream: FirebaseFirestore.instance.collection("Tasks").snapshots(),
        //it has stream property
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
                // ignore: unnecessary_cast
                itemCount: (snapshot.data! as QuerySnapshot).docs.length,
                //QuerySnapshot Contains the results of a query. It can contain zero or more objects
                itemBuilder: (context, index) {
                  DocumentSnapshot task =
                      // ignore: unnecessary_cast
                      (snapshot.data! as QuerySnapshot).docs[index];
                  return Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Material(
                                color: Colors.transparent,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: <Widget>[
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '${task['data']}',
                                              style: const TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.justify,
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  FirebaseFirestore.instance
                                                      .collection("Tasks")
                                                      .where("data",
                                                          isEqualTo: task[
                                                              'data']) //This line shows whick Task from friebase is identified
                                                      .get()
                                                      .then((snapshot) =>
                                                          snapshot.docs.first
                                                              .reference
                                                              .delete());
                                                },
                                                child:
                                                    const Icon(Icons.delete)),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              UpdateScreen(
                                                                  data: task[
                                                                      'data'])));
                                                },
                                                child: const Icon(Icons.update))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  );
                });
          }
        },
      ),
    );
  }
}
