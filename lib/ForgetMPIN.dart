import 'package:check_deposit/BalanceAmount.dart';
import 'package:check_deposit/Drawer_Page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

void main()
async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );

  runApp(const MaterialApp(
    title:'Navigation Basics',
    home: ForgetMPIN(),
  ));
}
class ForgetMPIN extends StatefulWidget {
  const ForgetMPIN({super.key});
  @override
  MyStateFulWidget createState() => MyStateFulWidget();
}
class MyStateFulWidget extends State<ForgetMPIN>
{
  TextEditingController mpin = TextEditingController();
  TextEditingController __password = TextEditingController();

  void initState()
  {
    super.initState();
    verifyPassword();
  }

  void verifyPassword()
  async{
  String enteredpw = __password.text;
  final String enteredmpin = mpin.text;
      // Reference to the document in the "users" collection. Replace 'userId' with the actual document ID you want to retrieve.
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('User Data').doc('Password_Details').get();
      // Get the "name" field from the snapshot.
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      String storedpw = data['Password'];

      if (storedpw == enteredpw)
        {
          DocumentReference docref2 = FirebaseFirestore.instance.collection('User Data').doc('Password_Details');
          await docref2.set({
            'MPIN':enteredmpin},SetOptions(merge: true));

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Drawer_Page()),
          );
        }
      else
        {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text('Incorrect Password'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
          );
        }

  }





  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('E-Deposit'),
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
        body: SingleChildScrollView(


          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top:25),
                child: const Text(
                  "Please enter your password!",
                  style: TextStyle(fontSize: 23,
                      fontWeight: FontWeight.w500,fontFamily: 'calibra'),
                ),
              ),


              Container(
                width: 350,
                height: 65,

                padding: const EdgeInsets.only(top: 7),
                child: TextField(
                  controller: __password,
                  style: const TextStyle(
                    fontSize: 19,

                    color: Colors.black,
                  ),

                  keyboardType: TextInputType.text,
                  cursorColor: Colors.blueGrey,
                  autofocus: true,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(
                      width: 1,color: Colors.teal.shade500,
                    ),
                        borderRadius: BorderRadius.circular(6)),


                    labelText: "Password",
                    labelStyle: TextStyle(
                      fontSize: 17,
                      color: Colors.teal[200],
                    ),
                    filled: true,
                    fillColor: Colors.teal.shade50,


                  ),
                ),
              ),

              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top:20),
                child: const Text(
                  "Please set your new MPIN",
                  style: TextStyle(fontSize: 23,
                      fontWeight: FontWeight.w500,fontFamily: 'calibra'),
                ),
              ),

              SizedBox(
                height: 10,
              ),

              SizedBox(
                child: Pinput(
                  controller: mpin,
                  obscureText: true,
                  length: 4,
                  defaultPinTheme: PinTheme(
                      height: 55,
                      width: 55,
                      textStyle: TextStyle(fontSize: 23),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: Colors.black

                          )
                      )
                  ),
                ),
              ),




              Container(
                padding: const EdgeInsets.only(top: 430),
                child: ConstrainedBox(
                    constraints: const BoxConstraints.tightFor(
                        height: 60,width: 350
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        verifyPassword();
                      },



                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal[600],
                        elevation: 16,
                        shadowColor: Colors.teal.shade100,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all((Radius.circular(30)))
                        ),
                      ),
                      child: const Text('Submit',
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
