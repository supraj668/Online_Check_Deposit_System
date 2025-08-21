import 'package:check_deposit/image_upload.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main()
async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(

    title:'Navigation Basics',
    home: Second(),
  ));
}
class Second extends StatelessWidget {



TextEditingController fname = TextEditingController();
TextEditingController lname = TextEditingController();
TextEditingController gender = TextEditingController();
TextEditingController pno = TextEditingController();

void _savePersonalDetailsAndNavigate( BuildContext context) async {
  final String data1 = fname.text;
  final String data2 = lname.text;
  final String data3 = gender.text;
 final String data4 = pno.text;

  // Save data to Firebase
  DocumentReference docref = FirebaseFirestore.instance.collection('User Data').doc('Personal_Details');

  await docref.set({'First Name': data1,
    'Last Name':data2,
    'Gender':data3,
  'Phone Number':data4},SetOptions(merge: true));




  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => image_upload()),
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
            onPressed: ()
            {
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
                child: Text("Please Enter Your Details",
                    textAlign: TextAlign.left,
                    maxLines: 3,
                    style: TextStyle(color: Colors.black,
                      fontSize: 22,fontFamily: 'Open Sans',
                    )
                ),
              ),


              Positioned(
                top: 45,
                left: 20,
                child: SizedBox(
                  width: 357,
                  height: 57,
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
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(
                        width: 1,color: Colors.teal.shade500,
                      )
                          ,borderRadius: BorderRadius.circular(6)),


                      labelText: "First Name",
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
                top: 115,
                left: 20,
                child: SizedBox(
                  width: 357,
                  height: 57,
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
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(
                        width: 1,color: Colors.teal.shade500,
                      )
                          ,borderRadius: BorderRadius.circular(6)),


                      labelText: "Last Name",
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
                top: 185,
                left: 20,
                child: SizedBox(
                  width: 357,
                  height: 57,
                  child: TextField(
                    controller: gender,
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
                      )
                          ,borderRadius: BorderRadius.circular(6)),


                      labelText: "Gender",
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
                top: 255,
                left: 20,
                child: SizedBox(
                  width: 357,
                  height: 57,
                  child: TextField(
                    controller: pno,

                    style: const TextStyle(
                      fontSize: 19,

                      color: Colors.black,
                    ),

                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                    ],
                    cursorColor: Colors.blueGrey,
                    autofocus: true,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(
                        width: 1,color: Colors.teal.shade500,
                      ),
                          borderRadius: BorderRadius.circular(6)),


                      labelText: "Phone number",
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
                top:650,
                left: 25,
                child: ConstrainedBox(
                    constraints: const BoxConstraints.tightFor(
                        height: 60,width: 350
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        if(fname.text.isEmpty || lname.text.isEmpty || gender.text.isEmpty || pno.text.isEmpty)
                          {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Error'),
                                content: Text('Please enter all the details',
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
                        else
                          {
                            _savePersonalDetailsAndNavigate(context);
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

  void setState(Null Function() param0) {}
}
