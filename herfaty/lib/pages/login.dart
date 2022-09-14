// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:math';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:herfaty/models/shopOwnerModel.dart';
import 'package:herfaty/pages/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:herfaty/pages/forget_password.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:herfaty/screens/owner_base_screen.dart';
import 'package:herfaty/models/shopOwnerModel.dart';
import 'package:herfaty/screens/customer_base_screen.dart';

class login extends StatefulWidget {
      const login({Key? key}) : super(key: key);



  @override
  State<login> createState() => _login();


}

class _login extends State<login> {
 final _formKey = GlobalKey<FormState>();


bool isShopOwner=false;
// final List<shopOwnerModel> shopOwners =[];
//  final FirebaseAuth auth="  ";
 TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
String OwnerId='';
  Stream<List<shopOwnerModel>> readShopOwner() => FirebaseFirestore.instance
      .collection('shop_owner')
      .where( "id", isEqualTo: OwnerId)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => shopOwnerModel.fromJson(doc.data())).toList());
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
              children: <Widget>[


                 
                
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                   
                 SizedBox(
                        height: 90,
                      ),
                      Image.asset(
                  "assets/images/HerfatyLogoCroped.png",
                  width: 180,
                ),
                 SizedBox(
                        height: 30,
                      ),
                      Text(
                        "تسجيل الدخول",
                        style: TextStyle(fontSize: 33, fontFamily: "Tajawal" 
                        ,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 26, 96, 91) ),
                        
                      ),

  SizedBox(
                        height: 10,
                      ),
  

                      // SizedBox(
                      //   height: 20,
                      // ),
                      

   SizedBox(
                        height: 30,
                      ),
                    
                    
//  Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
                          
//                            DropdownButton<String>(
//   // Step 3.
//   value: dropdownValue,
//   // Step 4.
//   items: <String>[ 'مالك المتجر','مشتري','مشرف']
//       .map<DropdownMenuItem<String>>((String value) {
//     return DropdownMenuItem<String>(
//       value: value,
      
//       child: Text(
//         value,
//         style: TextStyle(fontSize: 15),
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
//                           Text("  :تسجيل الدخول ك"),

                          
//                         ],
//                       ), 
                     
                      // SizedBox(
                      //   height: 1,
                      // ),
                      Container(
                        
                        // decoration: BoxDecoration(
                          
                        //   color: Color.fromARGB(255, 114, 159, 160),
                        //   borderRadius: BorderRadius.circular(66),
                          
                        // ),
                      //  width: 290,
                      //   height: 53,
                        padding: EdgeInsets.symmetric(horizontal: 60),
                        child: reusableTextField("البريد الإلكتروني", Icons.email, false,
                    _emailTextController),

                //  SizedBox(
                //   height: 20,
                //          ),

                     ),
                        // TextFormField(
                          
  //                         decoration: InputDecoration(
  //                           labelText: "البريد الإلكتروني",
  //                           labelStyle: TextStyle(color: Color.fromARGB(255, 26, 96, 91)),
  //                             suffix: Icon(
  //                               Icons.person,
  //                               color: Color.fromARGB(255, 26, 96, 91),
  //                             ),
  //                             // hintText: ": البريد الإلكتروني ",

  //                              enabledBorder:  OutlineInputBorder(
  //                                borderSide: BorderSide( color: Color.fromARGB(255, 26, 96, 91)), 
                                 
  //                             ),
  //                             focusedBorder:OutlineInputBorder(
  //                                borderSide: BorderSide(  width: 2,color: Color.fromARGB(255, 26, 96, 91)),
  //                                ),
  //                  ),
  //                                           validator: (value) {
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
                 
                   //    ),
                 
                      SizedBox(
                        height: 23,
                      ),
                      Container(
                        // decoration: BoxDecoration(
                        //   color: Color.fromARGB(255, 114, 159, 160),
                        //   borderRadius: BorderRadius.circular(0),
                        //   border:OutlinedBorder(),
                        // ),
                      //  width: 290,
                        // height: 53,
                        padding: EdgeInsets.symmetric(horizontal: 60),
                        child: 
                        
                        reusableTextField("كلمة المرور", Icons.lock, true,
                    _passwordTextController),
  //                   validator: (value) {
  //   if (value == null || value.isEmpty) {
  //     return 'ادخل الرمز السري';
  //   }
  //   return null;
  // },
  //                       ),
  //                       TextFormField(
                          

                          
  //                         obscureText: true,
  //                         decoration: InputDecoration(
  //                        labelText: "الرقم السري ",
  //                           labelStyle: TextStyle(color: Color.fromARGB(255, 26, 96, 91)),

  //                             suffix: Icon(
  //                               Icons.lock,
  //                               color: Color.fromARGB(255, 26, 96, 91),
  //                             ),
                            
                          
  //                             // hintText: ": الرقم السري ",
  //                              enabledBorder:  OutlineInputBorder(
  //                                borderSide: BorderSide( color: Color.fromARGB(255, 26, 96, 91)), 
                                 
  //                             ),
  //                             focusedBorder:OutlineInputBorder(
  //                                borderSide: BorderSide( width: 2,color: Color.fromARGB(255, 26, 96, 91)),
  //                                ),
  //                              ),
                               
  //                                           validator: (value) {
  //   if (value == null || value.isEmpty) {
  //     return 'ادخل الرمز السري';
  //   }
  //   return null;
  // },
  //                       ),
                      ),
                      SizedBox(
                        height: 17,
                      ),
                      ElevatedButton(
                        onPressed: () async {    
                           if (_formKey.currentState!.validate()) {

 
try{
                   UserCredential userCredentia =  await FirebaseAuth.instance
                            .signInWithEmailAndPassword(email: _emailTextController.text,
                          password: _passwordTextController.text);
  OwnerId='';
  OwnerId=userCredentia.user!.uid;
  readShopOwner();
  // .then((value) {
print('objectfuggrffffffffffffffffffff'+OwnerId);


try{

  
  print(readShopOwner().toString()[8]);
if(readShopOwner().toList().toString()!=''){
  print("Errrrrrrrrrrrrrrrrrrrrrrr");
  OwnerId='';
   Navigator.pushNamed(context, "/forget_password");
}
  else  {
                print("hhhhhhhhhhhhhhhhhhhhhhh");
                OwnerId='';
                     Navigator.pushNamed(context, '/welcomeRegestration');}

}
catch(e,stack){
     Navigator.pushNamed(context, "/forget_password");

}
             

                  // }).onError((error, stackTrace) {
                  //   print("Error hhhhhh");
                  // }
                
}
catch(e, stack){
  
                            showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("خطأ"),
              content: Text('البريد الإلكتروني أو كلمة المرور غير صحيح، حاول مجددا'),
              actions: <Widget>[
                TextButton(
                  child: Text("حسنا"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
                          
print("Error hhhhhh");
}                    


          //                   showDialog(
          // context: context,
          // builder: (BuildContext context) {
          //   return AlertDialog(
          //     title: Text("خطأ"),
          //     content: Text('البريد الإلكتروني أو كلمة المرور غير صحيح، حاول مجددا'),
          //     actions: <Widget>[
          //       TextButton(
          //         child: Text("حسنا"),
          //         onPressed: () {
          //           Navigator.of(context).pop();
          //         },
          //       )
          //     ],
          //   );
          // });
                          
                          
                    
                  
                   }
               
                      
                       
  
                           
                // }   
                  },
                  
                      
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xff51908E)),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric( horizontal: 90, vertical: 13)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(27))),
                        ),
                        child: Text(
                          "تسجيل الدخول",
                          style: TextStyle(fontSize: 14,fontFamily: "Tajawal",fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 17,
                      ),


                       Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){ Navigator.pushNamed(context, "/forget_password");},
                            child: Text("نسيت كلمة المرور؟", style: TextStyle(color: Color.fromARGB(255, 53, 47, 244),fontFamily: "Tajawal",decoration: TextDecoration.underline),)),

                          Text("",style:TextStyle(fontFamily: "Tajawal"),),

                          //  GestureDetector(
                          //       onTap: () {
                          //         Navigator.pushNamed(context, "/login");
                          //       },
                          //       child: Text(
                          //         "",
                          //         style: TextStyle(fontFamily: "Tajawal"),
                          //       ),
                          //     ),
                          //     TextButton(
                          //       child: Text(
                          //         "نسيت كلمة",
                          //         style: TextStyle(
                          //             decoration: TextDecoration.underline,
                          //             fontFamily: "Tajawal",color:Color.fromARGB(255, 53, 47, 244)),
                          //       ),
                          //       onPressed: () {
                          //         Navigator.push(
                          //           context,
                          //           MaterialPageRoute(
                          //               builder: (context) =>
                          //                   const forget_password()),
                          //         );
                          //       },
                          //     ),
                        ],
                      ), 
                       SizedBox(
                        height: 10,
                      ),

                      Row(
                        
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                               Text("ليس لديك حساب ؟",style:TextStyle(fontFamily: "Tajawal")),
                          GestureDetector(
                            onTap: (){ Navigator.pushNamed(context, "/welcomeRegestration");},
                            child: Text(" تسجيل جديد ", 
                            style: TextStyle(color: Color.fromARGB(255, 53, 47, 244),decoration: TextDecoration.underline ,fontFamily: "Tajawal"),)),

                     

                          
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
      )
      ),
    );  
    }

  StreamBuilder<List<shopOwnerModel>> ShopOwnerIdsFromDB() {
    return StreamBuilder<List<shopOwnerModel>>(
      
                  stream: readShopOwner(),
                  builder: (context, snapshot) {
                    print('sssssssssssssssssssssssssssssssss');
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      
                      return Text('Something went wrong! ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      //هنا حالة النجاح في استرجاع البيانات...........................................
                      //String detailsImage = "";
                      final AllshopOwners = snapshot.data!.toList();



print(OwnerId+"hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");


print('tttttttttttttttttttttttt');
for(int i=0;i<AllshopOwners.length ;i++){
     if(OwnerId==AllshopOwners[i].id){
         isShopOwner=true;
         break;
     }
     return  Text('');
}
      
                     
                      //..................................................................................
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                 return Text('');
                  },
                );
  }
}

String? validateEmail(String? formEmail){
      if (formEmail == null || formEmail.isEmpty) 
return 'أدخل البريد الإلكتروني';
 
 return null;
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