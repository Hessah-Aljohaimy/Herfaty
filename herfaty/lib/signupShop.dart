import 'package:flutter/material.dart';
import 'package:herfaty/reusable_widgits.dart';

class SignupShop extends StatefulWidget {
  const SignupShop({super.key});

  @override
  State<SignupShop> createState() => _SignupShopState();
}

class _SignupShopState extends State<SignupShop> {
  @override
  Widget build(BuildContext context) {
    // GestureDetector(
    //   onTap: () {},
    //   child: CircleAvatar(
    //     radius: MediaQuery.of(context).size.width * 0.10,
    //     backgroundColor: Colors.white,
    //     child: Icon(
    //       Icons.add_photo_alternate,
    //       color: Colors.grey,
    //       size: MediaQuery.of(context).size.width * 0.10,
    //     ),
    //   ),
    // ),

    final _formKey = GlobalKey<FormState>();
    TextEditingController _shopNameController = new TextEditingController();
    TextEditingController _shopDescriptionController =
        new TextEditingController();
    TextEditingController _shopLogoController = TextEditingController();
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
                       
                          Positioned(
                            top: 0,
                            left: 0,
                            child: ElevatedButton(
                              onPressed: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => const Welcome()),
                                // );
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.green),
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.symmetric(
                                        horizontal: 79, vertical: 10)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(27))),
                              ),
                              child: Text(
                                " العوده للصفحه الرئيسيه",
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),



                          
                          Text(
                            "تسجيل حساب جديد",
                            style: TextStyle(
                                fontSize: 35,
                                fontFamily: "myfont",
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 21,
                          ),
                          Text(
                            "معلومات المتجر",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: "myfont",
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 27,
                          ),
                          //////////////////Inputs Fields//////////////
                          // Container(
                          //   decoration: BoxDecoration(
                          //     color: Colors.green[100],
                          //     borderRadius: BorderRadius.circular(66),
                          //   ),
                          //   width: 266,
                          //   padding: EdgeInsets.symmetric(horizontal: 16),
                          //   child: TextField(
                          //     decoration: InputDecoration(
                          //         icon: Icon(
                          //           Icons.person,
                          //           color: Colors.white,
                          //         ),
                          //         hintText: "أدخل اسم المشتري",
                          //         border: InputBorder.none),
                          //   ),
                          // ),
                          Container(
                            width: 290,
                            height: 53,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: reusableTextField(
                                " اسم المتجر",
                                Icons.shop,
                                false,
                                _shopNameController),
                          ),

                          SizedBox(
                            height: 20,
                          ),
                          // Container(
                          //   decoration: BoxDecoration(
                          //     color: Colors.green[100],
                          //     borderRadius: BorderRadius.circular(66),
                          //   ),
                          //   width: 266,
                          //   padding: EdgeInsets.symmetric(horizontal: 16),
                          //   child: TextField(
                          //     decoration: InputDecoration(
                          //         icon: Icon(
                          //           Icons.email,
                          //           color: Colors.white,
                          //         ),
                          //         hintText: ":أدخل عنوان البريد الإلكتروني",
                          //         border: InputBorder.none),
                          //   ),
                          // ),
                          Container(
                            width: 290,
                            height: 53,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: reusableTextField(
                                "وصف عن المتجر",
                                Icons.email_rounded,
                                false,
                                _emailTextEditingController),
                          ),
                          SizedBox(
                            height: 23,
                          ),
                          // Container(















































      ),
    );
  }
}
