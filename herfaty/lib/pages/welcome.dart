// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

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
                    SizedBox(
                      height: 40,
                    ),
                  
                    Text("", style: TextStyle(fontSize: 33, fontFamily: "myfont"),),
                    SizedBox(
                      height: 33,
                    ),
                  
                     Image.asset(
                  "assets/images/logo_transparent.png",
                  width: 270,
                ),
                  
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/login");
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