import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DemoScreen extends StatefulWidget {
  const DemoScreen({Key? key}) : super(key: key);

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  Stream<QuerySnapshot<Map<String, dynamic>>> getDataStream() {
    return FirebaseFirestore.instance.collection('Employee').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: getDataStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            final documents = snapshot.data!.docs;

            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (BuildContext context, int index) {
                final document = documents[index].data();

                final name = document['name'] ?? 'No Title';
                final designation = document['designation'] ?? 'No Description';

                return ListTile(
                  title: Text(name),
                  subtitle: Text(designation),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
