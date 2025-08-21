import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
void main()
async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

  );

  runApp(const MaterialApp(
    title:'Navigation Basics',
    home: MyAccount(),
  ));
}

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});
  @override
  MyStateFulWidget createState() => MyStateFulWidget();
}
class MyStateFulWidget extends State<MyAccount>
{
   final TextEditingController _bankname = TextEditingController();
  final TextEditingController _accno = TextEditingController();
  final TextEditingController _ifsc = TextEditingController();


  @override
  void initState()
  {
    super.initState();
    retrieveData();
  }

  void retrieveData()
  async{
    try {
      // Reference to the document in the "users" collection. Replace 'userId' with the actual document ID you want to retrieve.
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('User Data').doc('Bank_Details').get();
      // Get the "name" field from the snapshot.
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      String bankname = data['Bank Name'];
      String accno = data['Account Number'];
      String ifsc = data['IFSC Code'];
      // Set the value in the TextField.
      _bankname.text = bankname;
      _accno.text = accno;
      _ifsc.text = ifsc;
    } catch (e) {
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
            onPressed: ()
            {
              Navigator.pop(context);
            },
          ),

        ),
        backgroundColor: Colors.white,
        body: Center(

          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [

              const Positioned(
                top:10,
                left: 20,
                child: Text("Bank Details",
                    textAlign: TextAlign.left,
                    maxLines: 3,
                    style: TextStyle(color: Colors.black,
                      fontSize: 22,fontFamily: 'Open Sans',
                    )
                ),
              ),


              Positioned(
                top: 55,
                left: 20,
                child: SizedBox(
                  width: 367,
                  height: 57,
                  child: TextField(
                    readOnly: true,
                    controller: _bankname,
                    style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(
                        width: 1,color: Colors.teal.shade500,
                      )
                          ,borderRadius: BorderRadius.circular(6)),
                      labelText: "Bank Name",
                      labelStyle: TextStyle(
                        fontSize: 17,
                        color: Colors.teal[200],
                      ),
                      filled: true,
                      fillColor: Colors.teal.shade50,


                    ),

                  ),

                ),
              ),

              Positioned(
                top: 135,
                left: 20,
                child: SizedBox(
                  width: 367,
                  height: 57,
                  child: TextField(
                    readOnly: true,
                    controller: _accno,
                      style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w500),



                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(
                        width: 1,color: Colors.teal.shade500,
                      )
                          ,borderRadius: BorderRadius.circular(6)),


                      labelText: "Account Number",
                      labelStyle: TextStyle(
                        fontSize: 17,
                        color: Colors.teal[200],
                      ),
                      filled: true,
                      fillColor: Colors.teal.shade50,


                    ),
                  ),
                ),
              ),

              Positioned(
                top: 215,
                left: 20,
                child: SizedBox(
                  width: 367,
                  height: 57,
                  child: TextField(
                    readOnly: true,
                    controller: _ifsc,
                    style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w500),



                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(
                        width: 1,color: Colors.teal.shade500,
                      )
                          ,borderRadius: BorderRadius.circular(6)),


                      labelText: "IFSC Code",
                      labelStyle: TextStyle(
                        fontSize: 17,
                        color: Colors.teal[200],
                      ),
                      filled: true,
                      fillColor: Colors.teal.shade50,


                    ),
                  ),
                ),
              ),







            ],
          ),

        ),
      ),
    );
  }
}
