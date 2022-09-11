// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:herfaty/pages/login.dart';
import 'package:herfaty/pages/reusable_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';



class forget_password extends StatefulWidget {
      const forget_password({Key? key}) : super(key: key);

  @override
  State<forget_password> createState() => _forget_password();
}

class _forget_password extends State<forget_password> {
   final _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();

Future resetPassword() async{
      try{
         if (_formKey.currentState!.validate()) {
      await  FirebaseAuth.instance.sendPasswordResetEmail(email: _emailTextController.text.trim());
                        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("إعادة تعيين كلمة المرور"),
              content: Text('تم إرسال رسالة إعادة تعيين كلمة المرور إلى بريدك الإلكتروني'),
              actions: <Widget>[
                TextButton(
                  child: Text("حسنا"),
                  onPressed: () {
                                       Navigator.of(context).pop();
                  },
                )
              ],
            );
          }); }
      }
      on FirebaseAuthException catch(e){

 showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
               title: Text("خطأ"),
              content: Text('البريد الإلكتروني غير موجود'),
              actions: <Widget>[
                TextButton(
                  child: Text("حسنا"),
                  onPressed: () {
                                       Navigator.of(context).pop();
                  },
                )
              ],
            );
          }
          );
      }
    }
    

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
                
                SizedBox(
                  
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                   
                 SizedBox(
                        height: 120,
                      ),
                      
                      Text(
                        "إعادة تعيين كلمة المرور",
                        style: TextStyle(fontSize: 33, fontFamily: "myfont" ,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 26, 96, 91),),
                        
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      

   SizedBox(
                        height: 70,
                      ),
                    
                    
                     
                      // SizedBox(
                      //   height: 0,
                      // ),
                      Container(
                        //  width: 290,
                        // height: 53, 
                        padding: EdgeInsets.symmetric(horizontal: 60),
                        child:  reusableTextField("البريد الإلكتروني", Icons.person , false,
                    _emailTextController),
  //                       TextFormField(
  //                         decoration: InputDecoration(
  //                           labelText: "البريد الإلكتروني",
  //                                                       labelStyle: TextStyle(color: Color.fromARGB(255, 26, 96, 91)),

  //                              suffix: Icon(
  //                               Icons.person,
  //                               color: Color.fromARGB(255, 26, 96, 91),
  //                             ),
  // enabledBorder:  OutlineInputBorder(
  //                                borderSide: BorderSide( color: Color.fromARGB(255, 26, 96, 91)), 
                                 
  //                             ),
  //                             focusedBorder:OutlineInputBorder(
  //                                borderSide: BorderSide( width: 2,color: Color.fromARGB(255, 26, 96, 91)),
  //                                ),
  //                              ),           
  //                               validator: (value) {
  //   if (value == null || value.isEmpty) {
  //     return 'ادخل البريد الإلكتروني';
  //   }
  //    if (!RegExp(
  //                     r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$")
  //                 .hasMatch(value)) {
  //               return 'ادخل بريد إلكتروني صحيح';
  //             }
  //   return null;
  // },          
  //                                 ),
                      ),
                     
                      SizedBox(
                        height: 17,
                      ),
                      ElevatedButton(
                           onPressed: resetPassword , 
//                           if (_formKey.currentState!.validate()) {


//  FirebaseAuth.instance.sendPasswordResetEmail(email: _emailTextController.text)
//                       .catchError((err){
          //                   showDialog(
          // context: context,
          // builder: (BuildContext context) {
          //   return AlertDialog(
          //     title: Text("خطأ"),
          //     content: Text('البريد الإلكتروني أو الرمز السري غير صحيح، حاول مجددا'),
          //     actions: <Widget>[
          //       TextButton(
          //         child: Text("حسنا"),
          //         onPressed: () {
          //                              Navigator.of(context).pop();
          //         },
          //       )
          //     ],
          //   );
          // });
                      //     }
                      //     )
                      // .then((value) => Navigator.of(context).pop()); 


                      
                          // }
                          
                        
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xff51908E)),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  horizontal: 106, vertical: 13)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(27))),
                        ),
                        child: Text(
                          "إعادة تعيين",
                          style: TextStyle(fontSize: 14, fontFamily: "Tajawal",fontWeight: FontWeight.bold),
                        ),
                      ),
                      
                      SizedBox(
                        height: 17,
                      ),


                       
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){ Navigator.pushNamed(context, "/login");},
                            child: Text(" الدخول ", style: TextStyle(fontFamily: "Tajawal", decoration: TextDecoration.underline,color: Color.fromARGB(255, 53, 47, 244)),)),

                          Text("الرجوع إلى صفحة ",style: TextStyle(fontFamily: "Tajawal"),),

                          
                        ],
                      )
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
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
              ],
            ),
          ),
        ),
      )),
    );  
    
// Future resetPassword() async{
//       try{
//       await  FirebaseAuth.instance.sendPasswordResetEmail(email: _emailTextController.text.trim());
//                         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Text("jlll"),
//               content: Text('البريد الإلكتروني أو الرمز السري غير صحيح، حاول مجددا'),
//               actions: <Widget>[
//                 TextButton(
//                   child: Text("حسنا"),
//                   onPressed: () {
//                                        Navigator.of(context).pop();
//                   },
//                 )
//               ],
//             );
//           });
//       }
//       on FirebaseAuthException catch(e){
// Navigator.of(context).pop();
//       }
//     }
    
    }
}


// var selcted = 'مشتري';  
 
//   // List of items in our dropdown menu
//   var loginAs = [   
//     'مالك المتجر',
//     'مشرف',

//   ];

//   String dropdownValue = 'مشتري';

// class Login extends StatefulWidget {
//       const Login({Key? key}) : super(key: key);
  
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
      
//       child: Scaffold(
//                 resizeToAvoidBottomInset: false,

//           body: SafeArea(
//         child: Scaffold(
//                   resizeToAvoidBottomInset: false,

//           body: SizedBox(
            
//             height: double.infinity,
//             width: double.infinity,
//             child: Stack(
//               children: [
                
//                 SizedBox(
//                   width: double.infinity,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                     DropdownButton<String>(
//   // Step 3.
//   value: dropdownValue,
//   // Step 4.
//   items: <String>[ 'مالك المتجر','مشرف','مشتري']
//       .map<DropdownMenuItem<String>>((String value) {
//     return DropdownMenuItem<String>(
//       value: value,
//       child: Text(
//         value,
//         style: TextStyle(fontSize: 30),
//       ),
//     );
//   }).toList(),
//   // Step 5.
//   onChanged: (String? newValue) {
//     setState(() {
//       dropdownValue = newValue!;
//     });
//   },
// ),
//                  SizedBox(
//                         height: 210,
//                       ),
//                       Text(
//                         "تسجيل الدخول",
//                         style: TextStyle(fontSize: 33, fontFamily: "myfont" ,),
                        
//                       ),
//                       SizedBox(
//                         height: 35,
//                       ),
                     
//                       SizedBox(
//                         height: 35,
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                           color: Color.fromARGB(255, 114, 159, 160),
//                           borderRadius: BorderRadius.circular(66),
                          
//                         ),
//                         width: 266,
//                         padding: EdgeInsets.symmetric(horizontal: 16),
//                         child: TextField(
//                           decoration: InputDecoration(
//                               icon: Icon(
//                                 Icons.person,
//                                 color: Color.fromARGB(255, 26, 96, 91),
//                               ),
//                               hintText: ": البريد الإلكتروني ",
//                               border: InputBorder.none),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 23,
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                           color: Color.fromARGB(255, 114, 159, 160),
//                           borderRadius: BorderRadius.circular(66),
//                         ),
//                         width: 266,
//                         padding: EdgeInsets.symmetric(horizontal: 16),
//                         child: TextField(
//                           obscureText: true,
//                           decoration: InputDecoration(
//                               suffix: Icon(
//                                 Icons.visibility,
//                                 color: Color.fromARGB(255, 26, 96, 91),
//                               ),
//                               icon: Icon(
//                                 Icons.lock,
//                                 color: Color.fromARGB(255, 26, 96, 91),
//                                 size: 19,
//                               ),
//                               hintText: ": الرقم السري ",
//                               border: InputBorder.none),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 17,
//                       ),
//                       ElevatedButton(
//                         onPressed: () {         },
                        
//                         style: ButtonStyle(
//                           backgroundColor:
//                               MaterialStateProperty.all(Color.fromARGB(255, 35, 125, 118)),
//                           padding: MaterialStateProperty.all(
//                               EdgeInsets.symmetric(
//                                   horizontal: 106, vertical: 10)),
//                           shape: MaterialStateProperty.all(
//                               RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(27))),
//                         ),
//                         child: Text(
//                           "تسجيل الدخول",
//                           style: TextStyle(fontSize: 14),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 17,
//                       ),
                      
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           GestureDetector(
//                             onTap: (){ Navigator.pushNamed(context, "/signup");},
//                             child: Text(" تسجيل جديد ", style: TextStyle(fontWeight: FontWeight.bold),)),

//                           Text("ليس لديك حساب مسبقا؟"),

                          
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//                 Positioned(
//                   left: 0,
//                   child: Image.asset(
//                     "assets/images/main_topp.png",
//                     width: 150,
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 0,
//                   right: 0,
//                   child: Image.asset(
//                     "assets/images/login_bottom.png",
//                     width: 200,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       )),
//     );
//   }
// }