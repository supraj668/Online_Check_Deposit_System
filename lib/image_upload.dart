import 'package:check_deposit/Bank.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
void main()
async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  runApp( const MaterialApp(
    title:'Navigation Basics',
    home: image_upload(),
  ));
}
class image_upload extends StatefulWidget {
  const image_upload({super.key});
  @override
  MyStateFulWidget createState() => MyStateFulWidget();
}
class MyStateFulWidget extends State<image_upload> {
  File? _imageFile;
  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

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
          .child('profile_images/${DateTime.now().millisecondsSinceEpoch}.png');

      await firebaseStorageRef.putFile(_imageFile!);

      final imageUrl = await firebaseStorageRef.getDownloadURL();

      // Store the image URL in Firestore
      await FirebaseFirestore.instance
          .collection('User Data')
          .doc('Profile_Photo') // Replace with the user ID or any unique identifier
          .set({'Profile_Image': imageUrl});

      print("Image URL: $imageUrl");
    } on FirebaseException catch (e) {
      print("Error uploading image: ${e.message}");
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Bank()),
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
          child: Center(
            child: Container(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 10,bottom: 20),
                      child: const Text(
                        "Upload your profile photo",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 23,
                          fontWeight: FontWeight.w500

                        ),
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        _pickImage();
                      },
                      iconSize: 80,
                      icon: const Icon(Icons.camera_alt_rounded),
                    ),




                    const SizedBox(
                      height: 5,
                    ),


                    if (_imageFile != null)

                        Image.file(
                          _imageFile!,
                          height: 250,
                          width: 300,
                          fit: BoxFit.cover,
                        ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 80),
                          child: ConstrainedBox(
                              constraints: const BoxConstraints.tightFor(
                                  height: 60,width: 120
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Bank()),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.teal[600],
                                    elevation: 16,
                                    shadowColor: Colors.teal.shade100,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all((Radius.circular(8)))
                                    )
                                ),
                                child: const Text('SKIP',
                                    style: TextStyle(color: Colors.black,fontSize: 20)),
                              )
                          ),
                        ),

                        Container(
                          margin: const EdgeInsets.only(top: 80),
                          child: ConstrainedBox(
                              constraints: const BoxConstraints.tightFor(
                                  height: 60,width: 120
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  if(_imageFile == null)
                                    {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text('Error'),
                                          content: Text('Please upload the image or skip this part',
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
                                child: const Text('SUBMIT',
                                    style: TextStyle(color: Colors.black,fontSize: 20)),
                              )
                          ),
                        ),
                      ],
                    ),


          ],
          ),

            ),
        ),
        ),
      ),
    );
  }
}