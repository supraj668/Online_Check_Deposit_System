import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'LoginPage.dart';
import 'firebase_options.dart';


void main()
async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MaterialApp(
    title:'Navigation Basics',
    home: ForgetPassword(),
  ));
}


class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});
  @override
  MyStateFulWidget createState() => MyStateFulWidget();
}
class MyStateFulWidget extends State<ForgetPassword>
{


  final TextEditingController _email = TextEditingController();
  final TextEditingController _newpassword = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  EmailAuth emailAuth =   EmailAuth(sessionName: "Sample session");



void resetPassword()
async{
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: _email.text);
    String newpw = _newpassword.text;
    await FirebaseFirestore.instance
        .collection('User Data').doc('Password_Details')
        .set({'Password': newpw},SetOptions(merge: true));

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
    // Success: Password reset email sent.
  } catch (e) {
    // Handle error: Display an error message to the user.
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
        body: Center(

          child: Column(

            children: [



              Container(
                padding: const EdgeInsets.only(top: 250),

                child: SizedBox(
                  width: 357,
                  height: 55,
                  child: TextField(
                    controller: _email,
                    style: const TextStyle(
                      fontSize: 19,

                      color: Colors.black,
                    ),


                    cursorColor: Colors.blueGrey,
                    autofocus: false,
                    decoration: InputDecoration(



                      hintText: "Enter your E-Mail",
                      hintStyle: TextStyle(
                        fontSize: 17,
                        color: Colors.teal[200],
                      ),
                      filled: true,
                      fillColor: Colors.teal.shade50,


                    ),
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.only(top: 10),

                child: SizedBox(
                  width: 357,
                  height: 55,
                  child: TextField(
                    controller: _newpassword,
                    style: const TextStyle(
                      fontSize: 19,

                      color: Colors.black,
                    ),


                    cursorColor: Colors.blueGrey,
                    autofocus: false,
                    decoration: InputDecoration(



                      hintText: "Enter your new password",
                      hintStyle: TextStyle(
                        fontSize: 17,
                        color: Colors.teal[200],
                      ),
                      filled: true,
                      fillColor: Colors.teal.shade50,


                    ),
                  ),
                ),
              ),







              Container(
                padding: const EdgeInsets.only(top: 10),
                child: ConstrainedBox(
                    constraints: const BoxConstraints.tightFor(
                        height: 50,width: 110
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        if(_email.text.isEmpty)
                          {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Error'),
                                content: Text('Please enter your email',
                                  style: TextStyle(fontSize: 20),),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('OK',
                                      style: TextStyle(fontSize: 17),),
                                  ),
                                ],
                              ),
                            );
                          }
                        else {
                          resetPassword();
                          resetPassword();
                        }

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal[600],
                        elevation: 16,
                        shadowColor: Colors.teal.shade100,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all((Radius.circular(10)))
                        ),
                      ),
                      child: const Text('confirm',
                          style: TextStyle(color: Colors.black,fontSize: 20)),
                    )
                ),
              ),

            ],
          ),

        ),
      ),
    );
  }

}