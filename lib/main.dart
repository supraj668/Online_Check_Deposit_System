import 'package:flutter/material.dart';
import 'package:check_deposit/Registration.dart';
import 'package:check_deposit/LoginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main()
async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    title:'Navigation Basics',
    home: MyApp(),
  ));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            const Positioned(
              top:60,
              child: Text("E-DEPOSIT",
                  style: TextStyle(color: Colors.black,
                      fontSize: 25,fontFamily: 'times new roman',
                      fontWeight: FontWeight.bold)
              ),

            ),
            Positioned(
              top:89,
              child: Text("Your mobile deposit platform",
                  style: TextStyle(color: Colors.grey[600],
                      fontSize: 17)
              ),

            ),

            const Positioned(

                top:140,
                height: 100,
                width: 100,
                child: Image(
                    image: AssetImage('images/cut.png')
                )
            ),


            const Positioned(
              top:230,


              child: Text("Make your way easy",
                  style: TextStyle(color: Colors.black,
                      fontSize: 18)
              ),

            ),
            Positioned(
              top:385,
              left: 20,

              //Extra
              child: Text("New user?",
                  style: TextStyle(color: Colors.grey[600],
                      fontSize: 15)
              ),

            ),
            Positioned(
              top:510,
              left: 20,
              child: Text("Already a user?",
                  style: TextStyle(color: Colors.grey[600],
                      fontSize: 15)
              ),
            ),
            Positioned(
              top:415,
              left: 25,
              child: ConstrainedBox(
                  constraints: const BoxConstraints.tightFor(
                      height: 60,width: 350
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => First()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal[600],
                        elevation: 16,
                        shadowColor: Colors.teal.shade100,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all((Radius.circular(30)))
                        )
                    ),
                    child: const Text('Registration',
                        style: TextStyle(color: Colors.black,fontSize: 20)),
                  )
              ),
            ),
            Positioned(
              top:540,
              left: 25,
              child: ConstrainedBox(
                  constraints: const BoxConstraints.tightFor(
                      height: 60,width: 350
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
                            borderRadius: BorderRadius.all((Radius.circular(30)))
                        )
                    ),
                    child: const Text('Login',
                        style: TextStyle(color: Colors.black,fontSize: 20)),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}


