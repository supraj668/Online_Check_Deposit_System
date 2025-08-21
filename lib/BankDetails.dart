import 'package:check_deposit/BalanceAmount.dart';
import 'package:check_deposit/mpin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:check_deposit/Drawer_Page.dart';

void main()
async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  runApp( MaterialApp(
    title:'Navigation Basics',
    home: BankDetails(),
  ));
}

class BankDetails extends StatefulWidget {
  const BankDetails({super.key});
  @override
  MyStateFulWidget createState() => MyStateFulWidget();
}
class MyStateFulWidget extends State<BankDetails>
{
  final _formkey = GlobalKey<FormState>();
  TextEditingController bname = TextEditingController();
  TextEditingController accountno = TextEditingController();
TextEditingController raccountno = TextEditingController();
TextEditingController _ifsc = TextEditingController();

  bool showWarning = false;


  @override
  void initState() {
    super.initState();

    bname.addListener(() {
      if(bname.text == "State Bank of India")
        {
          accountno.addListener(() {
            setState(() {
              showWarning = accountno.text.length < 11 || accountno.text.length > 11;
            });
          });
        }
      else if(bname.text == "Canara Bank") {
        accountno.addListener(() {
          setState(() {
            showWarning =
                accountno.text.length < 13 || accountno.text.length > 13;
          });
        });
      }
      else if(bname.text == "Karnataka Bank") {
        accountno.addListener(() {
          setState(() {
            showWarning =
                accountno.text.length < 16 || accountno.text.length > 16;
          });
        });
      }
      else if(bname.text == "ICIC Bank") {
        accountno.addListener(() {
          setState(() {
            showWarning =
                accountno.text.length < 12 || accountno.text.length > 12;
          });
        });
      }
      else if(bname.text == "HDFC Bank") {
        accountno.addListener(() {
          setState(() {
            showWarning =
                accountno.text.length < 14 || accountno.text.length > 14;
          });
        });
      }
      else if(bname.text == "Union Bank") {
        accountno.addListener(() {
          setState(() {
            showWarning =
                accountno.text.length < 15 || accountno.text.length > 15;
          });
        });
      }
      else if(bname.text == "Kotak Mahindra Bank") {
        accountno.addListener(() {
          setState(() {
            showWarning =
                accountno.text.length < 16 || accountno.text.length > 16;
          });
        });
      }
      else if(bname.text == "Bank of Baroda") {
        accountno.addListener(() {
          setState(() {
            showWarning =
                accountno.text.length < 14 || accountno.text.length > 14;
          });
        });
      }
      else if(bname.text == "Central Bank of India") {
        accountno.addListener(() {
          setState(() {
            showWarning =
                accountno.text.length < 10 || accountno.text.length > 10;
          });
        });
      }
      else if(bname.text == "Citi Bank") {
        accountno.addListener(() {
          setState(() {
            showWarning =
                accountno.text.length < 16 || accountno.text.length > 16;
          });
        });
      }
      else if(bname.text == "South Indian Bank") {
        accountno.addListener(() {
          setState(() {
            showWarning =
                accountno.text.length < 16 || accountno.text.length > 16;
          });
        });
      }

    });

  }
String branchName = '';
  void verifyIFSC()
  async{
    String ifsc_ = _ifsc.text;
    QuerySnapshot querysnapshot = await FirebaseFirestore.instance
        .collection('Bank Database')
        .where('IFSC Code', isEqualTo: ifsc_)
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
  void fetchHolderName()
 async {
    String accountno_ = accountno.text;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Bank Database')
        .where('Account Number', isEqualTo: accountno_)
        .limit(1)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      var data = querySnapshot.docs[0].data() as Map<String, dynamic>;
      var accHolderName = data['Account Holder Name'] as String?;

      setState(() {
        holderName = accHolderName!;

      });
    }
  }

  void _saveBankDetailsAndNavigate()
  async{
    String accountno_ = accountno.text;
     QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Bank Database')
        .where('Account Number', isEqualTo: accountno_)
     .limit(1)
        .get();
      if(snapshot.docs.isNotEmpty) {
       var data = snapshot.docs[0].data() as Map<String, dynamic>;
         var accountNoValue = data['Account Number'] as String?;
         if (accountno_ == accountNoValue) {

           await FirebaseFirestore.instance
               .collection('User Data').doc('Bank_Details')
               .set({'Bank Name': bname.text,
             'Account Number':accountno.text,
             'IFSC Code':_ifsc.text,
             'Account holder name':holderName});



           // Navigate to the next screen (replace 'NextScreen' with the actual screen widget)

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Mpin()),
    );
  }
}
      else
        {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Error'),
              content: Text('Bank not found'),
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


                Form(
                  key: _formkey,
                  child: Container(
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.only(top: 10),
                    child: const Text(
                      "Enter Bank Details",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 23,

                      ),
                    ),
                  ),
                ),

                Container(
                  width: 367,
                  height: 65,
                  margin: const EdgeInsets.only(top: 10),
                  child: TextField(
                    controller: bname,
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


                      labelText: "Enter Bank name",
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
                  child: TextFormField(

                    controller: accountno,
                    style: const TextStyle(
                      fontSize: 19,

                      color: Colors.black,
                    ),

                    keyboardType: TextInputType.text,
                    // validator: (value) => validateAccountNumber(bname.text, value!),

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
                SizedBox(
                    height: 4),
                if (showWarning)
                  Text(
                    'Please enter valid account number',
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.red),
                  ),


                Container(
                  width: 367,
                  height: 65,
                  margin: const EdgeInsets.only(top: 10),
                  child: TextFormField(
                    controller: raccountno,
                    style: const TextStyle(
                      fontSize: 19,

                      color: Colors.black,
                    ),

                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value != accountno.text) {
                        return 'Account numbers do not match';
                      }
                      return null;
                    },
                    cursorColor: Colors.blueGrey,
                    autofocus: true,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(
                        width: 1,color: Colors.teal.shade500,
                      ),
                          borderRadius: BorderRadius.circular(6)),


                      labelText: "Re-enter account number",
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
                        controller: _ifsc,
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
                              verifyIFSC();
                            fetchHolderName();
                            },
                            child: const Text('Verify',
                                style: TextStyle(color: Colors.black,fontSize: 14)),
                          )
                      ),
                    ),



                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  branchName,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize:17,color: Colors.black),
                ),
                const SizedBox(
                  height: 4,
                ),

                Text(
                   holderName,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize:20,color: Colors.green,fontWeight: FontWeight.w500),
                ),





                Container(
                  margin: const EdgeInsets.only(top: 95),
                  child: ConstrainedBox(
                      constraints: const BoxConstraints.tightFor(
                          height: 60,width: 350
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          if(bname.text.isEmpty || accountno.text.isEmpty || raccountno.text.isEmpty
                          || _ifsc.text.isEmpty)
                          {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Error'),
                                content: const Text('Please fill all the details.',
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
                          else if(accountno.text == raccountno.text)
                            {
                              _saveBankDetailsAndNavigate();
                            }
                          else
                            {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Error'),
                                  content: const Text("Account number doesn't match with Re-entered account number.",
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
                        child: const Text('CONFIRM',
                            style: TextStyle(color: Colors.black,fontSize: 20)),
                      )
                  ),
                ),

                Container(

                  margin: const EdgeInsets.only(top: 10),
                  child: const Text(
                    "This information will be securely saved as per E-Deposit Terms of Services and Privacy Policy.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,

                    ),
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
