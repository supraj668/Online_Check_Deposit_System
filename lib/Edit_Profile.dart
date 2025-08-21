import 'dart:io';

import 'package:check_deposit/Drawer_Page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main()
async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  runApp(const MaterialApp(
    title:'Navigation Basics',
    home: Edit_Profile(),
  ));
}

class Edit_Profile extends StatefulWidget {
  const Edit_Profile({super.key});
  @override
  MyStateFulWidget createState() => MyStateFulWidget();
}
class MyStateFulWidget extends State<Edit_Profile>
{
  final TextEditingController fname = TextEditingController();
  final TextEditingController lname = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pno = TextEditingController();
  String profileimageUrl = '';
  @override
  void initState()
  {
    super.initState();
    retrieveData();
    _fetchProfileImage();
  }

  Future<void> _fetchProfileImage() async {
    try {
      // Retrieve the profile image URL from Firestore
      final snapshot = await FirebaseFirestore.instance
          .collection('User Data')
          .doc('Profile_Photo') // Replace with the user ID or any unique identifier
          .get();

      setState(() {
        profileimageUrl = snapshot.data()?['Profile_Image'];
      });
    } catch (e) {
      print("Error fetching profile image: $e");
    }
  }

  void retrieveData()
  async{
    try {
      // Reference to the document in the "users" collection. Replace 'userId' with the actual document ID you want to retrieve.
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('User Data').doc('Personal_Details').get();
      // Get the "name" field from the snapshot.
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      String firstname = data['First Name'];
      String lastname = data['Last Name'];
      String email = data['E-mail'];
      String pno = data['Phone Number'];
      // Set the value in the TextField.
      fname.text = firstname;
      lname.text = lastname;
      _email.text = email;
      _pno.text = pno;
    } catch (e) {
      if (kDebugMode) {
        print("Error retrieving data: $e");
      }
    }
  }

  void saveEditsAndNavigate(BuildContext context) async {


    // Save data to Firebase
    await FirebaseFirestore.instance
        .collection('User Data').doc('Personal_Details')
        .set({'First Name': fname.text,
      'Last Name':lname.text,
      'E-mail':_email.text,
      'Phone Number':_pno.text},SetOptions(merge: true));

    DocumentReference docref4 = FirebaseFirestore.instance.collection('User Data').doc('Password_Details');
    await docref4.set({
      'Phone Number':_pno.text},SetOptions(merge: true));

    // Navigate to the next screen (replace 'NextScreen' with the actual screen widget)
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Drawer_Page()),
    );
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
                  padding: const EdgeInsets.only(left: 200,top: 10),
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 4,
                        color: Colors.white,
                      ),
                      shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: Image.network(
                      profileimageUrl,
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,

                    ),
                  ),
                ),




                Container(
                  width: 340,
                  height: 65,
                  margin: const EdgeInsets.only(top: 30),
                  child: TextField(
                    controller: fname,
                    style: const TextStyle(
                      fontSize: 19,

                      color: Colors.black,
                    ),

                    keyboardType: TextInputType.text,
                    cursorColor: Colors.blueGrey,
                    autofocus: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(
                        width: 1,color: Colors.teal.shade500,
                      ),
                          borderRadius: BorderRadius.circular(6)),
                      labelText: 'First name',



                      filled: true,
                      fillColor: Colors.teal.shade50,


                    ),
                  ),
                ),

                Container(
                  width: 340,
                  height: 65,
                  margin: const EdgeInsets.only(top: 10),
                  child: TextField(
                    controller: lname,
                    style: const TextStyle(
                      fontSize: 19,

                      color: Colors.black,
                    ),

                    keyboardType: TextInputType.text,
                    cursorColor: Colors.blueGrey,
                    autofocus: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(
                        width: 1,color: Colors.teal.shade500,
                      ),
                          borderRadius: BorderRadius.circular(6)),
                      labelText: 'Last name',


                      filled: true,
                      fillColor: Colors.teal.shade50,


                    ),
                  ),
                ),

                Container(
                  width: 340,
                  height: 65,
                  margin: const EdgeInsets.only(top: 10),
                  child: TextField(
                    controller: _email,
                    style: const TextStyle(
                      fontSize: 19,

                      color: Colors.black,
                    ),

                    keyboardType: TextInputType.text,
                    cursorColor: Colors.blueGrey,
                    autofocus: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(
                        width: 1,color: Colors.teal.shade500,
                      ),
                          borderRadius: BorderRadius.circular(6)),
                      labelText: 'E-mail',



                      filled: true,
                      fillColor: Colors.teal.shade50,


                    ),
                  ),
                ),

                Container(
                  width: 340,
                  height: 65,
                  margin: const EdgeInsets.only(top: 10),
                  child: TextField(
                    controller: _pno,
                    style: const TextStyle(
                      fontSize: 19,

                      color: Colors.black,
                    ),

                    keyboardType: TextInputType.text,
                    cursorColor: Colors.blueGrey,
                    autofocus: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(
                        width: 1,color: Colors.teal.shade500,
                      ),
                          borderRadius: BorderRadius.circular(6)),
                      labelText: 'phone no',



                      filled: true,
                      fillColor: Colors.teal.shade50,


                    ),
                  ),
                ),






                Container(
                  margin: const EdgeInsets.only(top: 80),
                  child: ConstrainedBox(
                      constraints: const BoxConstraints.tightFor(
                          height: 60,width: 340
                      ),
                      child: ElevatedButton(
                        onPressed: () => saveEditsAndNavigate(context),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal[600],
                            elevation: 16,
                            shadowColor: Colors.teal.shade100,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all((Radius.circular(30)))
                            )
                        ),
                        child: const Text('SAVE',
                            style: TextStyle(color: Colors.black,fontSize: 20)),
                      )
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
