import 'dart:io';

import 'package:check_deposit/MpinDeposit.dart';
import 'package:check_deposit/mpin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:check_deposit/Drawer_Page.dart';
import 'package:image_picker/image_picker.dart';


void main()
async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  runApp( const MaterialApp(
    title:'Navigation Basics',
    home: deposit_cheque(),
  ));
}

class deposit_cheque extends StatefulWidget {
  const deposit_cheque({super.key});
  @override
  MyStateFulWidget createState() => MyStateFulWidget();
}
class MyStateFulWidget extends State<deposit_cheque>
{
  TextEditingController dname = TextEditingController();
  TextEditingController accno = TextEditingController();
  TextEditingController ifsc = TextEditingController();
  TextEditingController amount = TextEditingController();

  bool showWarning = false;
  String _amount='';
  File? _imageFile;
  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_imageFile == null) return;

    try {
      final firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('cheque_images/${DateTime.now().millisecondsSinceEpoch}.png');

      await firebaseStorageRef.putFile(_imageFile!);

      final imageUrl = await firebaseStorageRef.getDownloadURL();
      print("Image URL: $imageUrl");
    } on FirebaseException catch (e) {
      print("Error uploading image: ${e.message}");
    }
  }


  String branchName = '';
  void VerifyIFSC()
  async{
    String Ifsc_ = ifsc.text;
    QuerySnapshot querysnapshot = await FirebaseFirestore.instance
        .collection('Bank Database')
        .where('IFSC Code', isEqualTo: Ifsc_)
        .limit(1)
        .get();
    if (querysnapshot.docs.isNotEmpty) {
      var data = querysnapshot.docs[0].data() as Map<String, dynamic>;
      var branchNameValue = data['Branch Name'] as String?;

      setState(() {
        branchName = branchNameValue!;

      });
    } else {
      setState(() {
        branchName = 'Branch not found';
      });
    }
  }

  String holderName = '';
  void FetchHolderName()
  async {
    String accountno_ = accno.text;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Bank Database')
        .where('Account Number', isEqualTo: accountno_)
        .limit(1)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      var data = querySnapshot.docs[0].data() as Map<String, dynamic>;
      var accHolderName = data['Account Holder Name'] as String;

      setState(() {
        holderName = accHolderName;

      });
    }
  }


  void _saveChequeDetailsAndNavigate(BuildContext context) async {
    String accountno_ = accno.text;
    Timestamp timeStamp = Timestamp.now();
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Bank Database')
        .where('Account Number', isEqualTo: accountno_)
        .limit(1)
        .get();
    if (snapshot.docs.isNotEmpty) {
      var data = snapshot.docs[0].data() as Map<String, dynamic>;
      var accountNoValue = data['Account Number'] as String?;
      if (accountno_ == accountNoValue) {
        // Save data to Firebase
        await FirebaseFirestore.instance
            .collection('User Data').doc('Cheque').collection('Cheque_details').
        add({'Drawer Name': dname.text,
          'Account number': accno.text,
          'MICR Code': ifsc.text,
          'timestamp': timeStamp,
          'Amount': amount.text});

        String amountText = amount.text;
        int amount2 = int.tryParse(amountText) ?? 0;
        await FirebaseFirestore.instance.collection('User Data').doc(
            'Account_Balance').update({
          'Balance': FieldValue.increment(amount2),
        });

        // Navigate to the next screen (replace 'NextScreen' with the actual screen widget)
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MpinDeposit()),
        );
      }
    }
    else
      {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text(' Drawer Bank not found'),
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
                  margin: const EdgeInsets.only(top: 1),

                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),


                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(top: 10),
                  child: const Text(
                    "Enter Cheque Details",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 23,

                    ),
                  ),
                ),




                Container(
                  width: 367,
                  height: 65,
                  margin: const EdgeInsets.only(top: 20),
                  child: TextField(
                    controller: dname,
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


                      labelText: "Drawer name",
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
                  width: 367,
                  height: 65,
                  margin: const EdgeInsets.only(top: 10),
                  child: TextField(
                    controller: accno,
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


                      labelText: "Account number",
                      labelStyle: TextStyle(
                        fontSize: 17,
                        color: Colors.teal[200],
                      ),
                      filled: true,
                      fillColor: Colors.teal.shade50,


                    ),
                  ),
                ),

                Row(
                  children: [
                    Container(
                      width: 270,
                      height: 65,

                      margin: const EdgeInsets.only(top: 10,right:10),
                      child: TextField(
                        controller: ifsc,
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


                          labelText: "IFSC code",
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
                      margin: const EdgeInsets.only(top: 6),

                      child: ConstrainedBox(
                          constraints: const BoxConstraints.tightFor(
                              height: 61,width: 70
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal[600],
                              elevation: 16,
                              shadowColor: Colors.teal.shade100,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all((Radius.circular(7)))
                              ),
                            ),
                            onPressed: () {
                              VerifyIFSC();
                              FetchHolderName();
                            },
                            child: const Text('Verify',
                                style: TextStyle(color: Colors.black,fontSize: 14)),
                          )
                      ),
                    ),



                  ],
                ),

                 SizedBox(
                  height: 4,
                ),
                Text(
                  branchName,
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize:17,color: Colors.black),
                ),
                SizedBox(
                  height: 4,
                ),

                Text(
                  holderName,
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize:20,color: Colors.green,fontWeight: FontWeight.w500),
                ),




                Container(
                  width: 367,
                  height: 65,
                  margin: const EdgeInsets.only(top: 10),
                  child: TextField(
                    controller: amount,
                    style: const TextStyle(
                      fontSize: 19,

                      color: Colors.black,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _amount = value;
                        showWarning = (int.tryParse(value)! > 50000);
                      });
                    },

                    keyboardType: TextInputType.text,
                    cursorColor: Colors.blueGrey,
                    autofocus: true,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(
                        width: 1,color: Colors.teal.shade500,
                      ),
                          borderRadius: BorderRadius.circular(6)),


                      labelText: "Amount",
                      labelStyle: TextStyle(
                        fontSize: 17,
                        color: Colors.teal[200],
                      ),
                      filled: true,
                      fillColor: Colors.teal.shade50,


                    ),
                  ),
                ),
                SizedBox(
                    height: 4),
                if (showWarning)
                  Text(
                    'Please enter the amount less than 50,000',
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.red),
                  ),

                Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: IconButton(
                    onPressed: () {
                       _pickImage();
                      },
                    iconSize: 57,
                    icon: const Icon(Icons.camera_alt),
                  )
                ),


                Container(
                  alignment: Alignment.center,
                  child: const Text("Upload image of cheque",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),),
                ),

                SizedBox(
                  height: 5,
                ),


                if (_imageFile != null)
                Image.file(
                  _imageFile!,
                  height: 250,
                  width: 300,
                  fit: BoxFit.cover,
                ),


                Container(
                  margin: const EdgeInsets.only(top: 130),
                  child: ConstrainedBox(
                      constraints: const BoxConstraints.tightFor(
                          height: 60,width: 350
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          if(dname.text.isEmpty || accno.text.isEmpty || ifsc.text.isEmpty || amount.text.isEmpty)
                            {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Error'),
                                  content: Text('Please fill required details',
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
                              _saveChequeDetailsAndNavigate(context);
                              _uploadImage();
                            }

                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal[600],
                            elevation: 16,
                            shadowColor: Colors.teal.shade100,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all((Radius.circular(8)))
                            )
                        ),
                        child: const Text('Deposit',
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
