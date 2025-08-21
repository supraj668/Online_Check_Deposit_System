import 'package:check_deposit/Drawer_Page.dart';
import 'package:check_deposit/ForgetPassword.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:check_deposit/main.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main()
async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  runApp( const MaterialApp(
    title:'Navigation Basics',
    home: LoginPage(),
  ));
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  MyStateFulWidget createState() => MyStateFulWidget();
}
class MyStateFulWidget extends State<LoginPage>
{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _pno = TextEditingController();
  final TextEditingController _pw = TextEditingController();
  bool _obscureText = true;
  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

@override
  void initState()
{
  super.initState();
  _loginUser(context);
}

  Future<void> _login() async {
      if (mounted) {

      }
      try {
        final UserCredential user = await _auth.signInWithEmailAndPassword(
          email: _pno.text,
          password: _pw.text,
        );
        // Check email verification
        if (!user.user!.emailVerified) {
          if (mounted) {
            setState(() {

            });
          }
          Fluttertoast.showToast(
              msg: "Please verify your email",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
          print("please verify your email");
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //       content: Text('Please verify your email before logging in')),
          // );

        } else {
          // navigate to new page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Drawer_Page()),
          );
        }
      } on FirebaseAuthException catch (e) {
        // Show error message if sign in failed
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message!)),
        );
      } finally {
        if (mounted) {
          setState(() {

          });
        }
      }

  }

  Future<void> _loginUser(BuildContext context) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('User Data').doc('Password_Details').get();
      // Get the "name" field from the snapshot.
      String enteredpno = _pno.text;
      String enteredpw = _pw.text;
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      String storedpno = data['Phone Number'];
      String storedpw = data['Password'];


      if (storedpno == enteredpno && storedpw == enteredpw)
      {
        // Phone number and password are correct, navigate to the next screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Drawer_Page()),
        );
      } else
      {
        // Invalid credentials, show an error message
         showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text('Invalid phone number or password. Please Register'),
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
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MyApp()),
                      );
                    },
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: const Text(
                    "LOG IN",
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 33,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),



                Container(
                  width: 367,
                  height: 65,
                  margin: const EdgeInsets.only(top: 120),
                  child: TextFormField(


                    controller: _pno,
                    style: const TextStyle(
                      fontSize: 19,

                      color: Colors.black,
                    ),

                    keyboardType: TextInputType.text,

                    cursorColor: Colors.blueGrey,
                    autofocus: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(
                        width: 1,color: Colors.teal.shade500,
                      ),
                          borderRadius: BorderRadius.circular(6)),


                      hintText: "Enter Your Email",
                      hintStyle: TextStyle(
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
                  margin: const EdgeInsets.only(top: 25),
                  child: TextFormField(
                    obscureText: _obscureText,
                    controller: _pw,
                    style: const TextStyle(
                      fontSize: 19,

                      color: Colors.black,
                    ),

                    keyboardType: TextInputType.text,
                    cursorColor: Colors.blueGrey,
                    autofocus: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(
                        width: 1,color: Colors.teal.shade500,
                      ),
                          borderRadius: BorderRadius.circular(6)),


                      hintText: "Password",
                      suffixIcon: GestureDetector(
                        onTap: _togglePasswordVisibility,
                        child: Icon(
                          _obscureText ? Icons.visibility : Icons.visibility_off,
                        ),
                      ),
                      hintStyle: TextStyle(
                        fontSize: 17,
                        color: Colors.teal[200],
                      ),
                      filled: true,
                      fillColor: Colors.teal.shade50,


                    ),
                  ),
                ),




                Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.only(top: 5),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForgetPassword()),
                      );
                    },
                    child: const Text('forget password?',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(top: 110),
                  child: ConstrainedBox(
                      constraints: const BoxConstraints.tightFor(
                          height: 60,width: 350
                      ),
                      child: ElevatedButton(
                        onPressed: () => _login(),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal[600],
                            elevation: 16,
                            shadowColor: Colors.teal.shade100,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all((Radius.circular(30)))
                            )
                        ),
                        child: const Text('LOGIN',
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
