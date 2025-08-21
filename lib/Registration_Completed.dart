import 'package:check_deposit/LoginPage.dart';
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
    home: Registration_Completed(),
  ));
}
class Registration_Completed extends StatefulWidget {
  const Registration_Completed({super.key});
  @override
  MyStateFulWidget createState() => MyStateFulWidget();
}
class MyStateFulWidget extends State<Registration_Completed>
{




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


          child:Center(
            child: Column(
              children: [

                Container(
                  padding: const EdgeInsets.only(top: 300),
                  child: const Text("Registration Completed, Please Login!",
                  style: TextStyle(fontSize: 23,fontWeight: FontWeight.w500),),
                ),

                Container(
                  padding: const EdgeInsets.only(top: 10),

                  child: ConstrainedBox(
                      constraints: const BoxConstraints.tightFor(
                          height: 50,width: 130
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPage()),
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
                        child: const Text('Login',
                            style: TextStyle(color: Colors.black,fontSize: 20)),
                      )
                  ),
                ),

              ],
            ),
          )


        ),
      ),
    );
  }


}
