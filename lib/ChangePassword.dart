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
    home: ChangePassword(),
  ));
}

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});
  @override
  MyStateFulWidget createState() => MyStateFulWidget();
}
class MyStateFulWidget extends State<ChangePassword>
{
  final TextEditingController currentp = TextEditingController();
  final TextEditingController newp = TextEditingController();
  final TextEditingController confirmp = TextEditingController();

  Future<void> changePasswordAndSave(BuildContext context) async {
    try {


      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('User Data').doc('Password_Details').get();
      // Get the "name" field from the snapshot.
      String enteredcurrentPw = currentp.text;
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      String storedcurrentpw = data['Password'];

      if (storedcurrentpw == enteredcurrentPw)
      {
        DocumentReference docref3 = FirebaseFirestore.instance.collection('User Data').doc('Password_Details');
        await docref3.set({
          'Password':newp.text},SetOptions(merge: true));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Drawer_Page()),
        );
      }
      else
      {
        // Invalid credentials, show an error message
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text("current password does not match old password."),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error logging in: $e');
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
                    "Please change your password",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),


                Container(
                  width: 367,
                  height: 65,
                  margin: const EdgeInsets.only(top: 10),
                  child: TextField(
                    controller: currentp,
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


                      hintText: "Enter your current password",
                      hintStyle: TextStyle(
                        fontSize: 17,
                        color: Colors.teal[200],
                      ),
                      filled: true,
                      fillColor: Colors.teal.shade50,


                    ),
                  ),
                ),

                Container(
                  width: 367,
                  height: 65,
                  margin: const EdgeInsets.only(top: 10),
                  child: TextField(
                    controller: newp,
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


                      hintText: "Enter new password",
                      hintStyle: TextStyle(
                        fontSize: 17,
                        color: Colors.teal[200],
                      ),
                      filled: true,
                      fillColor: Colors.teal.shade50,


                    ),
                  ),
                ),

                Container(
                  width: 367,
                  height: 65,
                  margin: const EdgeInsets.only(top: 10),
                  child: TextField(
                    controller: confirmp,
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


                      hintText: "Confirm Password",
                      hintStyle: TextStyle(
                        fontSize: 17,
                        color: Colors.teal[200],
                      ),
                      filled: true,
                      fillColor: Colors.teal.shade50,


                    ),
                  ),
                ),






                Container(
                  margin: const EdgeInsets.only(top: 300),
                  child: ConstrainedBox(
                      constraints: const BoxConstraints.tightFor(
                          height: 60,width: 350
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          if(newp.text.isEmpty || confirmp.text.isEmpty)
                            {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Error'),
                                  content: const Text("Please enter new password.",
                                    style: TextStyle(fontSize: 18),),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('OK',
                                        style: TextStyle(fontSize: 17),),
                                    ),
                                  ],
                                ),
                              );
                            }
                          else if(newp.text == confirmp.text)
                          {
                            changePasswordAndSave(context);
                          }
                          else
                            {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Error'),
                                  content: const Text("New password does not match. Enter new password again.",
                                    style: TextStyle(fontSize: 18),),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('OK',
                                        style: TextStyle(fontSize: 17),),
                                    ),
                                  ],
                                ),
                              );
                            }
                        },
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
