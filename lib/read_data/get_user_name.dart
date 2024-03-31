import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserName extends StatelessWidget {
  final String uid;
  const GetUserName({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<QuerySnapshot>(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text("Error fetching data");
          }
          final docs = snapshot.data?.docs ?? [];
          if (docs.isEmpty) {
            return Text("No user found");
          }
          final Map<String, dynamic> data =
              docs.first.data() as Map<String, dynamic>;
          return Card(
            elevation: 4,
            margin: EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.deepPurple,
                    child: Text(
                      '${data['first name'][0]}${data['last name'][0]}',
                      style: TextStyle(fontSize: 40, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '${data['first name']} ${data['last name']}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${data['email']}',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${data['age']} years old',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
      future: users.where('uid', isEqualTo: uid).get(),
    );
  }
}
