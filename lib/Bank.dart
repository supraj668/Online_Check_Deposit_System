import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:check_deposit/BankDetails.dart';


void main()
async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  runApp(const MaterialApp(
    title:'Navigation Basics',
    home: Bank(),
  ));
}

class Bank extends StatelessWidget {
  const Bank({super.key});


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
          title: const Text("Please select your bank",
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(

          child: Column(

            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                alignment: Alignment.topLeft,
                child: const Text("    Popular Banks",

                    maxLines: 3,
                    style: TextStyle(color: Colors.black,
                      fontSize: 16,fontFamily: 'Open Sans',
                    )
                ),

              ),


              Container(
                margin: const EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(),
                ),
                height: 200,
                width: 372,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [

                        IconButton(
                          splashRadius: 100,
                          iconSize: 65,
                          icon: Ink.image(
                            image: const AssetImage(
                                'images/ub.png'),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => BankDetails()),
                            );
                          },
                        ),
                        IconButton(
                          splashRadius: 100,
                          iconSize: 65,
                          icon: Ink.image(
                            image: const AssetImage(
                                'images/sbi.png'),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => BankDetails()),
                            );
                          },
                        ),
                      ],
                    ),


                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [

                        IconButton(
                          splashRadius: 100,
                          iconSize: 65,
                          icon: Ink.image(
                            image: const AssetImage(
                                'images/citi.png'),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => BankDetails()),
                            );
                          },
                        ),


                        IconButton(
                          splashRadius: 100,
                          iconSize: 65,
                          icon: Ink.image(
                            image: const AssetImage(
                                'images/federal.png'),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => BankDetails()),
                            );
                          },
                        ),
                      ],
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [

                        IconButton(
                          splashRadius: 100,
                          iconSize: 65,
                          icon: Ink.image(
                            image: const AssetImage(
                                'images/kotak.png'),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => BankDetails()),
                            );
                          },
                        ),


                        IconButton(
                          splashRadius: 100,
                          iconSize: 65,
                          icon: Ink.image(
                            image: const AssetImage(
                                'images/kb.png'),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => BankDetails()),
                            );
                          },
                        ),





                      ],
                    ),
                  ],

                ),
              ),




              Container(
                margin: const EdgeInsets.only(top: 10),
                alignment: Alignment.topLeft,
                child: const Text("    All Banks",

                    maxLines: 3,
                    style: TextStyle(color: Colors.black,
                      fontSize: 16,fontFamily: 'Open Sans',
                    )
                ),

              ),




              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      height: 60,
                      width: 372,
                      child: Row(
                        children: [
                          IconButton(
                            splashRadius: 100,
                            iconSize: 65,
                            icon: Ink.image(
                              image: const AssetImage(
                                  'images/ub.png'),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => BankDetails()),
                              );
                            },
                          ),

                          TextButton(onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => BankDetails()),
                            );
                          },
                              child: const Text("Union Bank",
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 17,color: Colors.black),))
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      height: 60,
                      width: 372,
                      child: Row(
                        children: [
                          IconButton(
                            splashRadius: 100,
                            iconSize: 65,
                            icon: Ink.image(
                              image: const AssetImage(
                                  'images/hdfc.png'),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => BankDetails()),
                              );
                            },
                          ),

                          TextButton(onPressed: (){
                            Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => BankDetails()),
                          );
                            },
                              child: const Text("HDFC Bank",
                                style: TextStyle(fontSize: 17,color: Colors.black),))
                        ],
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.all(10),
                      height: 60,
                      width: 372,
                      child: Row(
                        children: [
                          IconButton(
                            splashRadius: 100,
                            iconSize: 65,
                            icon: Ink.image(
                              image: const AssetImage(
                                  'images/sbi.png'),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => BankDetails()),
                              );
                            },
                          ),

                          TextButton(onPressed: (){Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => BankDetails()),
                          );},
                              child: const Text("State Bank of India",
                                style: TextStyle(fontSize: 17,color: Colors.black),))
                        ],
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.all(10),
                      height: 60,
                      width: 372,
                      child: Row(
                        children: [
                          IconButton(
                            splashRadius: 100,
                            iconSize: 65,
                            icon: Ink.image(
                              image: const AssetImage(
                                  'images/canara.webp'),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => BankDetails()),
                              );
                            },
                          ),

                          TextButton(onPressed: (){Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => BankDetails()),
                          );},
                              child: const Text("Canara Bank",
                                style: TextStyle(fontSize: 17,color: Colors.black),))
                        ],
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.all(10),
                      height: 60,
                      width: 372,
                      child: Row(
                        children: [
                          IconButton(
                            splashRadius: 100,
                            iconSize: 65,
                            icon: Ink.image(
                              image: const AssetImage(
                                  'images/bob.png'),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => BankDetails()),
                              );
                            },
                          ),

                          TextButton(onPressed: (){Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => BankDetails()),
                          );},
                              child: const Text("Bank of Baroda",
                                style: TextStyle(fontSize: 17,color: Colors.black),))
                        ],
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.all(10),
                      height: 60,
                      width: 372,
                      child: Row(
                        children: [
                          IconButton(
                            splashRadius: 100,
                            iconSize: 65,
                            icon: Ink.image(
                              image: const AssetImage(
                                  'images/icic.png'),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => BankDetails()),
                              );
                            },
                          ),

                          TextButton(onPressed: (){Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => BankDetails()),
                          );},
                              child: const Text("ICIC Bank",
                                style: TextStyle(fontSize: 17,color: Colors.black),))
                        ],
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.all(10),
                      height: 60,
                      width: 372,
                      child: Row(
                        children: [
                          IconButton(
                            splashRadius: 100,
                            iconSize: 65,
                            icon: Ink.image(
                              image: const AssetImage(
                                  'images/cbi.png'),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => BankDetails()),
                              );
                            },
                          ),

                          TextButton(onPressed: (){Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => BankDetails()),
                          );},
                              child: const Text("Central Bank of India",
                                style: TextStyle(fontSize: 17,color: Colors.black),))
                        ],
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.all(10),
                      height: 60,
                      width: 372,
                      child: Row(
                        children: [
                          IconButton(
                            splashRadius: 100,
                            iconSize: 65,
                            icon: Ink.image(
                              image: const AssetImage(
                                  'images/citi.png'),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => BankDetails()),
                              );
                            },
                          ),

                          TextButton(onPressed: (){Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => BankDetails()),
                          );},
                              child: const Text("Citibank",
                                style: TextStyle(fontSize: 17,color: Colors.black),))
                        ],
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.all(10),
                      height: 60,
                      width: 372,
                      child: Row(
                        children: [
                          IconButton(
                            splashRadius: 100,
                            iconSize: 65,
                            icon: Ink.image(
                              image: const AssetImage(
                                  'images/federal.png'),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => BankDetails()),
                              );
                            },
                          ),

                          TextButton(onPressed: (){Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => BankDetails()),
                          );},
                              child: const Text("Federal Bank",
                                style: TextStyle(fontSize: 17,color: Colors.black),))
                        ],
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.all(10),
                      height: 60,
                      width: 372,
                      child: Row(
                        children: [
                          IconButton(
                            splashRadius: 100,
                            iconSize: 65,
                            icon: Ink.image(
                              image: const AssetImage(
                                  'images/kb.png'),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => BankDetails()),
                              );
                            },
                          ),

                          TextButton(onPressed: (){Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => BankDetails()),
                          );},
                              child: const Text("Karnataka Bank",
                                style: TextStyle(fontSize: 17,color: Colors.black),))
                        ],
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.all(10),
                      height: 60,
                      width: 372,
                      child: Row(
                        children: [
                          IconButton(
                            splashRadius: 100,
                            iconSize: 65,
                            icon: Ink.image(
                              image: const AssetImage(
                                  'images/kotak.png'),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => BankDetails()),
                              );
                            },
                          ),

                          TextButton(onPressed: (){Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => BankDetails()),
                          );},
                              child: const Text("Kotak Mahindra Bank",
                                style: TextStyle(fontSize: 17,color: Colors.black),))
                        ],
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.all(10),
                      height: 60,
                      width: 372,
                      child: Row(
                        children: [
                          IconButton(
                            splashRadius: 100,
                            iconSize: 65,
                            icon: Ink.image(
                              image: const AssetImage(
                                  'images/sib.png'),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => BankDetails()),
                              );
                            },
                          ),

                          TextButton(onPressed: (){Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => BankDetails()),
                          );},
                              child: const Text("South Indian Bank",
                                style: TextStyle(fontSize: 17,color: Colors.black),))
                        ],
                      ),
                    ),
                  ],
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
