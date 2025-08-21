import 'package:check_deposit/BalanceAmount.dart';
import 'package:check_deposit/Drawer_Page.dart';
import 'package:check_deposit/Registration_Completed.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

void main()
async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );

  runApp(const MaterialApp(
    title:'Navigation Basics',
    home: Mpin(),
  ));
}
class Mpin extends StatefulWidget {
  const Mpin({super.key});
  @override
  MyStateFulWidget createState() => MyStateFulWidget();
}
class MyStateFulWidget extends State<Mpin>
{
  TextEditingController mpin = TextEditingController();
  TextEditingController cmpin = TextEditingController();

  void _saveMpinAndNavigate( BuildContext context) async {
    final String data1 = mpin.text;

    // Save data to Firebase
    DocumentReference docref2 = FirebaseFirestore.instance.collection('User Data').doc('Password_Details');
    await docref2.set({
      'MPIN':data1},SetOptions(merge: true));

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Registration_Completed()),
    );

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
                  "Please Set Your Six"
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

              SizedBox(
                height: 20,
              ),

              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top:10),
                child: const Text(
                  "Confirm your MPIN",
                  style: TextStyle(fontSize: 23,
                      fontWeight: FontWeight.w500,fontFamily: 'calibra',color: Colors.grey),
                ),
              ),

              SizedBox(
                height: 20,
              ),

              SizedBox(
                child: Pinput(
                  controller: cmpin,
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
                padding: const EdgeInsets.only(top: 290),
                child: ConstrainedBox(
                    constraints: const BoxConstraints.tightFor(
                        height: 60,width: 350
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        if(mpin.text.isEmpty || cmpin.text.isEmpty)
                          {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Error'),
                                content: const Text('Please set your pin.',
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
                        else if(mpin.text == cmpin.text)
                          {
                            _saveMpinAndNavigate(context);
                          }
                        else
                          {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Error'),
                                content: const Text("MPIN does not match.",
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
