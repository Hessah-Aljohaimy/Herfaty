import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      
      child: Scaffold(
        body: Container(
        // SizedBox(
  height: double.infinity,
          width: double.infinity,


  decoration: const BoxDecoration(
    image: DecorationImage(
        image: AssetImage(
                  "assets/images/main_topp.png"),
        fit: BoxFit.cover),
  ),
          
          child: Stack(
            
            children: [
              SizedBox(
                width: double.infinity,
             
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    
                  
                    ElevatedButton(
                      onPressed: () {

                        FirebaseAuth.instance.signOut().then((value){
                          print("singed out");
                        Navigator.pushNamed(context, "/login");
                      });
                      },
                      
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 35, 125, 118)),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 77, vertical: 10)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(27))),
                      ),
                      child: Text(
                        "تسجيل الدخول",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 22,
                    ),
                  
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/");
                      },
                      
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color.fromARGB(255, 114, 159, 160)),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 77, vertical: 9)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(27))),
                      ),
                      child: Text(
                        "تسجيل جديد",
                        style: TextStyle(fontSize: 22, color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
                  ],
                ),
              ),
              // Positioned(
              //   left: 0,
              //   child: Image.asset(
              //     "assets/images/main_topp.png",
              //     width: 444,
                  
              //   ),
              // ),
              // // Positioned(
              //   bottom: 0,
              //   child: Image.asset(
              //     "assets/images/main_bottom.png",
              //     width: 111,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}