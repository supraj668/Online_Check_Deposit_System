import 'package:check_deposit/Personal_Details.dart';
import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

void main()
async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(

    title:'Navigation Basics',
    home: First(),
  ));
}


class First extends StatefulWidget {
  const First({super.key});
  @override
  MyStateFulWidget createState() => MyStateFulWidget();
}
class MyStateFulWidget extends State<First>
{

  final TextEditingController _email = TextEditingController();
   final TextEditingController _otp = TextEditingController();

   final FirebaseAuth _auth = FirebaseAuth.instance;
   EmailAuth emailAuth =   EmailAuth(sessionName: "Sample session");



  void _signup() async {
      try {
        final UserCredential userCred =
        await _auth.createUserWithEmailAndPassword(
          email: _email.text,
          password: _otp.text,
        );

        if (!userCred.user!.emailVerified) {
          await userCred.user!.sendEmailVerification();
          Fluttertoast.showToast(
              msg: "Verification email sent",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );


          // Save data to Firebase
          await FirebaseFirestore.instance
              .collection('User Data').doc('Personal_Details')
              .set({'E-mail': _email.text});
          await FirebaseFirestore.instance
              .collection('User Data').doc('Password_Details')
              .set({'Password': _otp.text});

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Second()),
          );

        }
      } on FirebaseAuthException catch (e) {
        // Show error message if sign up failed
        Fluttertoast.showToast(
            msg: e.message!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      } finally {
        setState(() {

        });
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

          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [

              const Positioned(
                top:10,
                left: 20,
                child: Text("Add your Mail, we'll need  to confirm it by\nverification.",
                    textAlign: TextAlign.left,
                    maxLines: 3,
                    style: TextStyle(color: Colors.black,
                      fontSize: 18,fontFamily: 'Open Sans',
                    )
                ),
              ),

              Positioned(
                top: 85,
                left: 20,
                child: SizedBox(
                  width: 357,
                  child: TextField(
                    controller: _email,
                    style: const TextStyle(
                      fontSize: 19,

                      color: Colors.black,
                    ),


                    cursorColor: Colors.blueGrey,
                    autofocus: false,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(
                        width: 1,color: Colors.teal.shade500,
                      )
                          ,borderRadius: BorderRadius.circular(6)),


                      labelText: "Enter your E-Mail",
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
                top: 165,
                left: 20,
                child: SizedBox(
                  width: 357,
                  child: TextField(
                    controller: _otp,
                    style: const TextStyle(
                      fontSize: 19,

                      color: Colors.black,
                    ),


                    cursorColor: Colors.blueGrey,
                    autofocus: false,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(
                        width: 1,color: Colors.teal.shade500,
                      )
                          ,borderRadius: BorderRadius.circular(6)),


                      labelText: "Enter Password",
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
                top:620,
                left: 25,
                child: ConstrainedBox(
                    constraints: const BoxConstraints.tightFor(
                        height: 60,width: 350
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        if(_email.text.isEmpty && _otp.text.isEmpty)
                          {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Error'),
                                content: const Text('Please enter your email and OTP.',
                                  style: TextStyle(fontSize: 20),),
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
                        else if(_otp.text.isEmpty)
                          {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Error'),
                                content: Text('Please verify OTP.',
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
                        else{
                          _signup();
                          // _saveDataAndNavigate(context);
                        }

                      },



                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal[600],
                          elevation: 16,
                          shadowColor: Colors.teal.shade100,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all((Radius.circular(30)))
                          ),
                      ),
                      child: const Text('Register',
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