import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main()
async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  runApp( MaterialApp(
    title:'Navigation Basics',
    home: Transactions(),
  ));
}
class Transactions extends StatefulWidget {
  const Transactions({super.key});
  @override
  MyStateFulWidget createState() => MyStateFulWidget();
}
class MyStateFulWidget extends State<Transactions>
{

  List<DocumentSnapshot> documents = [];

  void fetchDataFromFirestore() async {
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collectionGroup('Cheque_details').get();

    setState(() {
      documents = querySnapshot.docs;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchDataFromFirestore();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal[600],
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text("E-Deposit"),
        ),
        backgroundColor: Colors.white,
        body: ListView.builder(
          itemCount: documents.length,
          itemBuilder: (context, index) {
            var document = documents[index];
            var data = document.data() as Map<String, dynamic>;
            var value1 = data['Account number']; // Use null-aware operator to perform a conditional access
            var value2 = data['Drawer Name'];
            var timestamp = data['timestamp'] as Timestamp?;
            DateTime dateTime = timestamp?.toDate() ?? DateTime.now();

            return Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: ListTile(
              title: Text('Transaction ID: ${document.id}',
                style: const TextStyle(fontSize: 19),),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Account Number: ${data['Account number']}',
                  style: const TextStyle(fontSize: 17),),
                  Text('Drawer Name: ${data['Drawer Name']}',
                    style: const TextStyle(fontSize: 17),),
                  Text('Time: $dateTime',
                    style: const TextStyle(fontSize: 17),),
                  Text('Amount: ${data['Amount']}',
                    style: const TextStyle(fontSize: 17),),
                ],
              ),
              ),
            );
          },
        ),
      ),
    );
  }
}
