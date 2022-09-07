// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      
      child: Scaffold(
                resizeToAvoidBottomInset: false,

          body: SafeArea(
        child: Scaffold(
                  resizeToAvoidBottomInset: false,

          body: SizedBox(
            
            height: double.infinity,
            width: double.infinity,
            child: Stack(
              children: [
                
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 210,
                      ),
                      Text(
                        "تسجيل الدخول",
                        style: TextStyle(fontSize: 33, fontFamily: "myfont" ,),
                        
                      ),
                      SizedBox(
                        height: 35,
                      ),
                     
                      SizedBox(
                        height: 35,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 114, 159, 160),
                          borderRadius: BorderRadius.circular(66),
                          
                        ),
                        width: 266,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          decoration: InputDecoration(
                              icon: Icon(
                                Icons.person,
                                color: Color.fromARGB(255, 26, 96, 91),
                              ),
                              hintText: ": البريد الإلكتروني ",
                              border: InputBorder.none),
                        ),
                      ),
                      SizedBox(
                        height: 23,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 114, 159, 160),
                          borderRadius: BorderRadius.circular(66),
                        ),
                        width: 266,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                              suffix: Icon(
                                Icons.visibility,
                                color: Color.fromARGB(255, 26, 96, 91),
                              ),
                              icon: Icon(
                                Icons.lock,
                                color: Color.fromARGB(255, 26, 96, 91),
                                size: 19,
                              ),
                              hintText: ": الرقم السري ",
                              border: InputBorder.none),
                        ),
                      ),
                      SizedBox(
                        height: 17,
                      ),
                      ElevatedButton(
                        onPressed: () {         },
                        
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Color.fromARGB(255, 35, 125, 118)),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  horizontal: 106, vertical: 10)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(27))),
                        ),
                        child: Text(
                          "تسجيل الدخول",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 17,
                      ),
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){ Navigator.pushNamed(context, "/signup");},
                            child: Text(" تسجيل جديد ", style: TextStyle(fontWeight: FontWeight.bold),)),

                          Text("ليس لديك حساب مسبقا؟"),

                          
                        ],
                      )
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  child: Image.asset(
                    "assets/images/main_topp.png",
                    width: 150,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Image.asset(
                    "assets/images/login_bottom.png",
                    width: 200,
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}