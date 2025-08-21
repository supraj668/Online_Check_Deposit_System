import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main()
async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

  );
  runApp( const MaterialApp(
    title:'Navigation Basics',
    home: BalanceAmount(),
  ));
}

class BalanceAmount extends StatefulWidget {
  const BalanceAmount({super.key});
  @override
  MyStateFulWidget createState() => MyStateFulWidget();
}
class MyStateFulWidget extends State<BalanceAmount>
{
  late int accountno_;

  final TextEditingController balance = TextEditingController();
  final TextEditingController selectedbank = TextEditingController();
  @override
  void initState()
  {
    super.initState();
    retrieveData();
  }
  void retrieveData()
  async{
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('User Data').doc('Bank_Details').get();
      // Get the "name" field from the snapshot.
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      String bank = data['Bank Name'];
      // Set the value in the TextField.
      selectedbank.text = bank;

// Reference to the document in the "users" collection. Replace 'userId' with the actual document ID you want to retrieve.
  DocumentSnapshot snapshot1 =  await FirebaseFirestore.instance.collection(
      'User Data').doc('Account_Balance').get();
  // Get the "name" field from the snapshot.
  Map<String, dynamic> data1 = snapshot1.data() as Map<String, dynamic>;
  int bal = data1['Balance'];
  // Set the value in the TextField.
  balance.text = "₹$bal";

    }
    catch (e) {
      if (kDebugMode) {
        print("Error retrieving data: $e");
      }
    }
  }




    @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal[600],
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text("E-Deposit"),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Container(
            margin: const EdgeInsets.only(top: 5),
            width: double.infinity,
            child: Column(
              children: [


                Container(
                  alignment: Alignment.topLeft,

                  child: const Text(
                    "Check balance",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.only(top:10),
                  alignment: Alignment.topLeft,


                  child: const Text(
                    "Savings account-",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                Container(

                  alignment: Alignment.topLeft,
                  child: TextField(
                    controller: selectedbank,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration:InputDecoration(
                        border: InputBorder.none,
                        ),
                  ),
                ),


                Container(
                  padding: const EdgeInsets.only(top:15),
                  alignment: Alignment.topLeft,


                  child: const Text(
                    "Account balance",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Container(

                  alignment: Alignment.topLeft,
                        child:  TextField(
                          controller: balance,
                        readOnly: true,
                        style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w500),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          filled: false,
                          fillColor: Colors.grey
                        ),

                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
