import 'package:check_deposit/BalanceAmount.dart';
import 'package:check_deposit/Drawer_Page.dart';
import 'package:check_deposit/ForgetMPIN.dart';
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
    home: MpinDeposit(),
  ));
}
class MpinDeposit extends StatefulWidget {
  const MpinDeposit({super.key});
  @override
  MyStateFulWidget createState() => MyStateFulWidget();
}
class MyStateFulWidget extends State<MpinDeposit>
{
  TextEditingController mpin = TextEditingController();


  @override
  void initState()
  {
    super.initState();
    verifyMpin();
  }

  void verifyMpin() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('User Data').doc('Password_Details').get();
      // Get the "name" field from the snapshot.
      String enteredMpin = mpin.text;
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      String storedMpin = data['MPIN'];

      if (storedMpin == enteredMpin) {
        // Phone number and password are correct, navigate to the next screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Drawer_Page()),
        );
      } else
      {
        // Invalid credentials, show an error message
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text('Incorrect MPIN'),
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
                padding: const EdgeInsets.only(top:100),
                child: const Text(
                  "Please enter your Six"
                      " Digit MPIN",
                  style: TextStyle(fontSize: 23,
                      fontWeight: FontWeight.w500,fontFamily: 'calibra'),
                ),
              ),
              SizedBox(
                height: 20,
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
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.only(top: 5,right: 15),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ForgetMPIN()),
                    );
                  },
                  child: const Text('forget MPIN?',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),


              Container(
                padding: const EdgeInsets.only(top: 310),
                child: ConstrainedBox(
                    constraints: const BoxConstraints.tightFor(
                        height: 60,width: 350
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        verifyMpin();
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
