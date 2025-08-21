import 'package:check_deposit/BankBalance.dart';
import 'package:check_deposit/ChangePassword.dart';
import 'package:check_deposit/Edit_Profile.dart';
import 'package:check_deposit/MyAccount.dart';
import 'package:check_deposit/Transactions.dart';
import 'package:check_deposit/deposit_cheque.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:check_deposit/LoginPage.dart';


void main()
async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );

  runApp( const MaterialApp(
    title:'Navigation Basics',
    home: Drawer_Page(),
  ));
}


class Drawer_Page extends StatefulWidget {
  const Drawer_Page({super.key});
  @override
  MyStateFulWidget createState() => MyStateFulWidget();
}
class MyStateFulWidget extends State<Drawer_Page>
{
  final TextEditingController _username = TextEditingController();
   String profileImageUrl = '';
  List<DocumentSnapshot> documents = [];

  void fetchDataFromFirestore() async {
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collectionGroup('Cheque_details').get();

    setState(() {
      documents = querySnapshot.docs;
    });
  }



  @override
  void initState()
  {
    super.initState();
  retrieveData();
    _fetchProfileImage();
    fetchDataFromFirestore();
  }

  Future<void> _fetchProfileImage() async {
    try {
      // Retrieve the profile image URL from Firestore
      final snapshot = await FirebaseFirestore.instance
          .collection('User Data')
          .doc('Profile_Photo') // Replace with the user ID or any unique identifier
          .get();

      setState(() {
        profileImageUrl = snapshot.data()?['Profile_Image'];
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

      // Set the value in the TextField.
      _username.text = firstname;

    } catch (e) {
      if (kDebugMode) {
        print("Error retrieving data: $e");
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const Text("E-Deposit",
              textAlign: TextAlign.center),
        ),
        
        drawer: Drawer(
          width: 280,
          elevation: 110.0,
          child: ListView(
            children: [
              DrawerHeader(
                padding: const EdgeInsets.all(0),
                child: Container(
                  color: Colors.teal,

                    child: Stack(
                      children:[
                      Positioned(
                        bottom: 55,
                        left: 100,
                        child: Container(

                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: Colors.white,
                              ), shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                        child: Image.network(
                        profileImageUrl,
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                          
                    ),
                      ),

                        ),
                      ),

                        Container(
                          padding: const EdgeInsets.only(top: 100,left:105),

                          child: TextField(
                            controller: _username,
                          style: const TextStyle(fontSize: 17,
                          fontWeight: FontWeight.bold),
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                filled: false,
                                fillColor: Colors.grey
                            ),),
                        )
          ]
                    ),

                ),


              ),
              ListTile(
                  title: const Text("Edit Profile",
                    style: TextStyle(fontSize: 17),),
                  leading: const Icon(Icons.account_circle_rounded,
                    color: Colors.black,
                    size: 40,),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Edit_Profile()),
                    );
                  }
              ),
              ListTile(
                  title: const Text("My Account",
                    style: TextStyle(fontSize: 17),),
                  leading: const Icon(Icons.account_balance,
                    color: Colors.black,
                    size: 40,),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MyAccount()),
                    );
                  }
              ),
              ListTile(
                  title: const Text("Deposit check",
                    style: TextStyle(fontSize: 17),),
                  leading: const Icon(Icons.add_card,
                    color: Colors.black,
                    size: 40,),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const deposit_cheque()),
                    );
                  }
              ),
              ListTile(
                  title: const Text("Check bank balance",
                    style: TextStyle(fontSize: 17),),
                  leading: const Icon(Icons.account_balance,
                    color: Colors.black,
                    size: 40,),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const BankBalance()),
                    );
                  }
              ),
              ListTile(
                  title: const Text("Transactions",
                    style: TextStyle(fontSize: 17),),
                  leading: const Icon(Icons.history_edu_rounded,
                    color: Colors.black,
                    size: 40,),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Transactions()),
                    );
                  }
              ),
              ListTile(
                  title: const Text("Change password",
                    style: TextStyle(fontSize: 17),),
                  leading: const Icon(Icons.password,
                    color: Colors.black,
                    size: 40,),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ChangePassword()),
                    );
                  }
              ),

              ListTile(

                title: const Text('Logout',
                  style: TextStyle(fontSize: 17,color: Colors.red),),
                leading: const Icon(Icons.logout,
                  color: Colors.red,
                  size: 40,),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(


            child: Column(
              children: [

                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(left: 20,top: 5),
                  child: const Text("Make your way easy",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      fontFamily: "calibra"
                    )
                  )
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 10,left: 20),
                        height: 200,
                        width: 370,
                        child: const Image(
                            image: AssetImage('images/image2.png',
                            ),
                            fit: BoxFit.cover,
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.only(top: 10,left: 20),
                        height: 200,
                        width: 370,
                        child: const Image(
                          image: AssetImage('images/pic5.jpg',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.only(top: 10,left: 20),
                        height: 200,
                        width: 370,
                        child: const Image(
                          image: AssetImage('images/image1.jpg',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: const EdgeInsets.only(top:15),
                  child: ConstrainedBox(
                      constraints: const BoxConstraints.tightFor(
                          height: 60,width: 370
                      ),
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const deposit_cheque()),
                          );
                        },
                        style: OutlinedButton.styleFrom(

                            elevation: 16,
                            shadowColor: Colors.teal.shade100,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all((Radius.circular(10)))
                            )
                        ),
                        child: const Text('Deposit cheque',
                            style: TextStyle(color: Colors.black,fontSize: 20)),
                      )
                  ),
                ),

                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(top: 15,left: 12,bottom: 10),
                  child: const Text("Recent transaction",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),),
                ),

                
                 
                   ListView.builder(
                    shrinkWrap: true,
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      var document = documents[index];
                      var data = document.data() as Map<String, dynamic>;
                      var value1 = data['Account number']; // Use null-aware operator to perform a conditional access
                      var value2 = data['Drawer Name'];
                      var timestamp = data['timestamp'] as Timestamp?;
                      DateTime dateTime = timestamp?.toDate() ?? DateTime.now();

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 5),


                          child: ListTile(
                            title: Text('Transaction ID: ${document.id}',
                              style: const TextStyle(fontSize: 19),),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Account Number: ${data['Account number']}',
                                  style: const TextStyle(fontSize: 17),),
                                Text('Drawer Name: ${data['Drawer Name']}',
                                  style: const TextStyle(fontSize: 17),),
                                Text('Time: $dateTime',
                                  style: const TextStyle(fontSize: 17),),
                                Text('Amount: ${data['Amount']}',
                                  style: const TextStyle(fontSize: 17),),
                              ],
                            ),
                          ),

                      );
                    },
                  ),










              ],
            ),
          ),

      ),
    );
  }
}