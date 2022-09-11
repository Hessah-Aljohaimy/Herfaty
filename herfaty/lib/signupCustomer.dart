import 'package:flutter/material.dart';

import 'package:herfaty/reusable_widgits.dart';
import 'package:herfaty/test_Login.dart';

class SignupCustomer extends StatefulWidget {
  const SignupCustomer({super.key});

  @override
  State<SignupCustomer> createState() => _SignupCustomerState();
}

class _SignupCustomerState extends State<SignupCustomer> {
  final emailController = TextEditingController();
  final numberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextEditingController = TextEditingController();
  TextEditingController _nameTextEditingController = TextEditingController();
  @override
//   void initState(){
// super.initState();
// emailController.addListener(() {setState(() {

// });})
//   }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
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
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Image.asset(
                      "assets/images/login_toppp.png",
                      width: 150,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Image.asset(
                      "assets/images/main_botomm.png",
                      width: 200,
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20,
                          ),

                          Container(
                              child: Image.asset(
                            "assets/images/HerfatyLogoCroped.png",
                            height: 120,
                          )),
                          Text(
                            "تسجيل حساب جديد",
                            style: TextStyle(
                              fontSize: 35,
                              fontFamily: "Tajawal",
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 26, 96, 91),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          Text(
                            "معلومات المشتري",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Tajawal",
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(248, 228, 175, 122),
                            ),
                          ),
                          SizedBox(
                            height: 27,
                          ),
                          //////////////////Inputs Fields//////////////

                          Container(
                            width: 290,
                            height: 53,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            // child: TextFormField (
                            //   validator: (value) => value.isEmpty?'ادخل اسم المشتري الثنائي':null,

                            child: reusableTextField(
                                " اسم المشتري الثنائي",
                                Icons.person_outline,
                                false,
                                _nameTextEditingController),
                          ),

                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 290,
                            height: 53,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: reusableTextField(
                                "البريد الإلكتروني",
                                Icons.email_rounded,
                                false,
                                _emailTextEditingController),
                          ),
                          SizedBox(
                            height: 23,
                          ),
                          Container(
                            width: 290,
                            height: 53,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: reusableTextField("كلمة المرور", Icons.lock,
                                true, _passwordTextController),
                          ),
                          SizedBox(
                            height: 23,
                          ),
                          SizedBox(
                            height: 17,
                          ),
                          SizedBox(
                            height: 17,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // FirebaseAuth.instance.singIn
                                //FirebaseAuth.instance..createUserWithEmailAndPassword(email:_emailTextEditingController.text,password:_passwordTextController.text).then((value) (){
                                //Navigator.push(context,MaterialPageRoute(builder:(context)=>HomeScreen()));
                                //
                                //
                                //});
                                print(' ');
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 26, 96, 91)),
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                      horizontal: 89, vertical: 10)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(27))),
                            ),
                            child: Text(
                              "سجل الحساب",
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                          SizedBox(
                            height: 33,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, "/login");
                                },
                                child: Text(
                                  " هل لديك حساب بالفعل؟",
                                  style: TextStyle(fontFamily: "Tajawal"),
                                ),
                              ),
                              TextButton(
                                child: Text(
                                  " تسجيل الدخول",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontFamily: "Tajawal"),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const TestLogin()),
                                  );
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 17,
                          ),
                          SizedBox(
                            width: 299,
                            child: Row(
                              children: [
                                Expanded(
                                    child: Divider(
                                  thickness: 0.6,
                                  color: Color.fromARGB(255, 26, 96, 91),
                                )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
Future registerWithEmailAndPassword(String email)
}
