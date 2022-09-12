import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:herfaty/pages/login.dart';
import 'package:herfaty/pages/reusable_widgets.dart';
import 'package:herfaty/pages/welcomeRegestration.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';

// ignore_for_file: file_names, prefer_const_constructors

class SignupHerafy extends StatefulWidget {
  const SignupHerafy({Key? key}) : super(key: key);

  @override
  State<SignupHerafy> createState() => _SignupHerafyState();
}

class _SignupHerafyState extends State<SignupHerafy> {
  int currentStep = 0;

  DateTime date = DateTime(2017, 12, 30);
  final _formKey = GlobalKey<FormState>();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextEditingController = TextEditingController();
  TextEditingController _nameTextEditingController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
TextEditingController _BODController=TextEditingController();
  TextEditingController _PhoneNumberTextEditingController =
      TextEditingController();

  TextEditingController _shopnameTextEditingController =
      TextEditingController();
  TextEditingController _shoplogoEditingController = TextEditingController();

  TextEditingController _shopdescriptionTextEditingController =
      TextEditingController();
PickedFile? _imageFile;
  final ImagePicker _picker = ImagePicker();




  List<Step> stepList() => [
    
        Step(
          
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: Text('معلومات الحرفي'),
          content: Column(
            children: <Widget>[
              
              Container(
                  child: Image.asset(
                "assets/images/HerfatyLogoCroped.png",
                height: 120,
              )),
         
              // Positioned(
              //   bottom: 0,
              //   right: 0,
              //   child: Image.asset(
              //     "assets/images/main_botomm.png",
              //     width: 200,
              //   ),
              // ),
           
              SizedBox(
                height: 20,
              ),
              // ignore: prefer_const_constructors
              Text(
                "تسجيل حساب جديد",
                // ignore: prefer_const_constructors
                style: TextStyle(
                  fontSize: 35,
                  fontFamily: "Tajawal",
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 26, 96, 91),
                ),
              ),
              // ignore: prefer_const_constructors
              SizedBox(
                height: 20,
              ),

              SizedBox(
                height: 10,
              ),

              // ignore: prefer_const_constructors
              Text(
                "معلومات الحرفي",
                // ignore: prefer_const_constructors
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "Tajawal",
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(248, 228, 175, 122),
                ),
              ),
              // ignore: prefer_const_constructors
              SizedBox(
                height: 27,
              ),
              Container(
                // width: 290,
                // height: 53,
                // padding: EdgeInsets.symmetric(horizontal: 16),
                  padding: EdgeInsets.symmetric(horizontal: 60),
                child: reusableTextField("اسم الحرفي", Icons.person,
                    false, _nameTextEditingController),
              ),

              SizedBox(
                height: 20,
              ),

              Container(
                // width: 290,
                // height: 53,
                // padding: EdgeInsets.symmetric(horizontal: 16),
                  padding: EdgeInsets.symmetric(horizontal: 60),
                child: reusableTextField("البريد الإلكتروني",
                    Icons.email_rounded, false, _emailTextEditingController),
              ),

              SizedBox(
                height: 23,
              ),

              Container(
                // width: 290,
                // height: 53,
                // padding: EdgeInsets.symmetric(horizontal: 16),
                  padding: EdgeInsets.symmetric(horizontal: 60),
                child: reusableTextField(
                    "كلمة المرور", Icons.lock, true, _passwordTextController),
              ),
Container(
padding: const EdgeInsets.only(left:85),
                                    child:
                          Text("* كلمه المرور لا تقل عن 6 خانات", style: 
                          TextStyle(color: Color.fromARGB(255, 164, 46, 46)),),),
              SizedBox(
                height: 17,
              ),
Container(
                  width: 290,
                  height: 53,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Center(
                      child: TextField(
                    controller: _BODController,
                    //editing controller of this TextField
                    decoration: InputDecoration(
                      suffix: Icon(
                        Icons.calendar_today_rounded,
                        color: Color.fromARGB(255, 26, 96, 91),
                      ),
                      labelText: "تاريخ الميلاد",
                      labelStyle:
                          TextStyle(color: Color.fromARGB(106, 26, 96, 91)),
                      fillColor: Colors.white.withOpacity(0.3),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 26, 96, 91)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: Color.fromARGB(255, 26, 96, 91)),
                      ),
                    ),

                    readOnly:
                        true, //set it true, so that user will not able to edit text
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(
                            2000), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101),

                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.light(
                                primary: Color(0xff51908E), // <-- SEE HERE
                                onPrimary: Colors.white, // <-- SEE HERE
                                onSurface: Colors.black, // <-- SEE HERE
                              ),
                              textButtonTheme: TextButtonThemeData(
                                style: TextButton.styleFrom(
                                  primary:
                                      Color(0xff51908E), // button text color
                                ),
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );

                      if (pickedDate != null) {
                        print(
                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        print(
                            formattedDate); //formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement

                        setState(() {
                          _BODController.text =
                              formattedDate; //set output date to TextField value.
                        });
                      } else {
                        print("لم يتم اختيار تاريخ الميلاد");
                      }
                    },
                  ))),
              // Container( ///////////////يدخل العمر ك رقمممممم
              //   // width: 290,
              //   // height: 53,
              //   // padding: EdgeInsets.symmetric(horizontal: 16),
              //     padding: EdgeInsets.symmetric(horizontal: 60),
              //   child: reusableTextFieldForAge("عمر الطفل",
              //       Icons.calendar_today_rounded, false, _dateController),
              // ),
              ///////////////////////////Importing DatePicker//////////////////////

              // GestureDetector(
              //   onTap: () async {
              //     DateTime? newDate = await showDatePicker(
              //         context: context,
              //         initialDate: date,
              //         firstDate: DateTime(2007),
              //         lastDate: DateTime(2017));

              //     //if cancelled
              //     if (newDate == null) return;
              //     //if not null
              //     setState(() => date = newDate);
              //   },
              //   child: Container(
              //       child: Padding(
              //     padding: const EdgeInsets.all(30.0),
              //     child: TextField(
              //       controller: _dateController,
              //       decoration: const InputDecoration(
              //         icon: Icon(Icons.calendar_today_rounded),
              //         labelText: ' تاريخ الميلاد',
              //       ),
              //     ),
              //   )),
              // ),
              // ElevatedButton(
              //   child: Text('أدخل تاريخ الميلاد'),
              //   onPressed: () async {
              //     DateTime? newDate = await showDatePicker(
              //         context: context,
              //         initialDate: date,
              //         firstDate: DateTime(2007),
              //         lastDate: DateTime(2017));

              //     //if cancelled
              //     if (newDate == null) return;
              //     //if not null
              //     setState(() => date = newDate);
              //   },
              // ),
              // Container(
              //   width: 290,
              //   height: 53,
              //   padding: EdgeInsets.symmetric(horizontal: 16),
              //   child: TextField(
              //     controller: _dateController,
              //     onTap: () {
              //       _selectDate(context);
              //     },
              //   ),
              // ),
              SizedBox(
                height: 17,
              ),

              Container(
                // width: 290,
                // height: 53,
                // padding: EdgeInsets.symmetric(horizontal: 16),
                  padding: EdgeInsets.symmetric(horizontal: 60),
                child: reusableTextFieldForAge("رقم الجوال", Icons.phone_android,
                    false, _PhoneNumberTextEditingController),
              ),
              SizedBox(
                height: 17,
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
                      ),
                    ),
                    TextButton(
                      child: Text(
                        " تسجيل الدخول",
                        style: TextStyle(
                          decoration: TextDecoration.underline
                       ,color: Color.fromARGB(255, 53, 47, 244) ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const login()),
                        );
                      },
                    ),
                  ],
                ),
                   SizedBox(
                height: 17,
              ),
              
            ],
          ),
        ),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: Text('معلومات المتجر'),
          content: Container(
            child: Column(
              children: <Widget>[
                
              Container(
                  child: Image.asset(
                "assets/images/HerfatyLogoCroped.png",
                height: 120,
              )),
                // Positioned(
                //   left: 0,
                //   top: 0,
                //   child: Image.asset(
                //     "assets/images/login_toppp.png",
                //     width: 150,
                //   ),
                // ),
                // Positioned(
                //   bottom: 0,
                //   right: 0,
                //   child: Image.asset(
                //     "assets/images/main_botomm.png",
                //     width: 200,
                //   ),
                // ),
                // ignore: prefer_const_constructors
                SizedBox(
                  height: 20,
                ),
                // ignore: prefer_const_constructors
                Text(
                  "تسجيل حساب جديد",
                  // ignore: prefer_const_constructors
                  style: TextStyle(
                    fontSize: 35,
                    fontFamily: "Tajawal",
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 26, 96, 91),
                  ),
                ),
                // ignore: prefer_const_constructors
                SizedBox(
                  height: 21,
                ),
                // ignore: prefer_const_constructors
                Text(
                  "معلومات المتجر",
                  // ignore: prefer_const_constructors
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: "Tajawal",
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(248, 228, 175, 122),
                  ),
                ),
                // ignore: prefer_const_constructors
                SizedBox(
                  height: 27,
                ),

                Text(
                  "أرفق صورة الشعار الخاصة بك",
                  // ignore: prefer_const_constructors
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Tajawal",
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 26, 96, 91),
                  ),
                ),
                imageProfile(),

////////////////////////////Importing Picture //////////////////////////////////
 SizedBox(
                  height: 27,
                ),

                Container(
                  // width: 290,
                  // height: 53,
               padding: EdgeInsets.symmetric(horizontal: 60),
                  child: reusableTextField("اسم المتجر", Icons.shop, false,
                      _shopnameTextEditingController),
                ),

                SizedBox(
                  height: 20,
                ),

                Container(
                  // width: 290,
                  // height: 53,
                  padding: EdgeInsets.symmetric(horizontal: 60),
                  child: reusableTextFieldDec("وصف المتجر", Icons.shop_2, false,
                      _shopdescriptionTextEditingController),
                ),

                SizedBox(
                  height: 17,
                ),

                SizedBox(
                  height: 17,
                ),
                Text("هيا لتبدأ رحلتك!"),
                SizedBox(
                  height: 6,
                ),
                ElevatedButton(
                  onPressed: () {
//1 Authentication

//2 Routing
                    Navigator.of(context).pushNamed("home_screen");
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                       Color(0xff51908E)),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 90, vertical: 13)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(27))),
                  ),
                  child: Text(
                    "تسجيل الحساب",
                    style: TextStyle(fontSize: 14,fontFamily: "Tajawal",fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 33,
                ),
                 Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Text("هل لديك حساب بالفعل؟ ",style: TextStyle(fontFamily: "Tajawal"),),
                          GestureDetector(
                            onTap: (){ Navigator.pushNamed(context, "/login");},
                            child: Text("تسجيل الدخول ", style: TextStyle(fontFamily: "Tajawal", decoration: TextDecoration.underline,color: Color.fromARGB(255, 53, 47, 244)),)),

                         

                          
                        ],
                      ),
                SizedBox(
                  height: 17,
                ),
              ],
            ),
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Scaffold(
        body: Stepper(
          type: StepperType.horizontal,

          currentStep: currentStep,
          onStepContinue: () {
            final isLastStep = currentStep == stepList().length - 1;
            if (isLastStep) {
              print('Completed');
            } else {
              setState(() => currentStep += 1);
            }
          },

          onStepCancel: () {
            currentStep == 0 ? null : setState(() => currentStep -= 1);
          },
          controlsBuilder: (BuildContext context, ControlsDetails controls) {
            return Row(
              children: <Widget>[
                // Positioned(
                //   left: 0,
                //   child: Image.asset(
                //     "assets/images/login_toppp.png",
                //     width: 150,
                //   ),
                // ),
                // Positioned(
                //   bottom: 0,
                //   right: 0,
                //   child: Image.asset(
                //     "assets/images/main_botomm.png",
                //     width: 200,
                //   ),
                // ),
                if (currentStep != 1)
                  Expanded(
                    child: ElevatedButton(
                      child: Text("التالي"),
                      onPressed: controls.onStepContinue,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                           Color(0xff51908E)),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 90, vertical: 13)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(27))),
                      ),
                    ),
                  ),
                const SizedBox(width: 12),
                if (currentStep != 0)
                  Expanded(
                    child: ElevatedButton(
                      child: Text("السابق"),
                      onPressed: controls.onStepCancel,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(248, 228, 175, 122)),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 90, vertical: 13)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(27))),
                      ),
                    ),
                  ),
              ],
            );
          },
          steps: stepList(),
//controls buldier

//           child: Scaffold(
//             body: SizedBox(
//               height: double.infinity,
//               width: double.infinity,
//               child: Stack(
//                 children: [
//                   SizedBox(
//                     width: double.infinity,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: <Widget>[
// //get image from user

//                         // ignore: prefer_const_constructors
//                         SizedBox(
//                           height: 20,
//                         ),
//                         // ignore: prefer_const_constructors
//                         Text(
//                           "تسجيل حساب جديد",
//                           // ignore: prefer_const_constructors
//                           style: TextStyle(
//                               fontSize: 35,
//                               fontFamily: "myfont",
//                               color: Colors.black),
//                         ),
//                         // ignore: prefer_const_constructors
//                         SizedBox(
//                           height: 21,
//                         ),
//                         // ignore: prefer_const_constructors
//                         Text(
//                           "معلومات الحرفي",
//                           // ignore: prefer_const_constructors
//                           style: TextStyle(
//                               fontSize: 20,
//                               fontFamily: "myfont",
//                               color: Colors.black),
//                         ),
//                         // ignore: prefer_const_constructors
//                         SizedBox(
//                           height: 27,
//                         ),
//                         Container(
//                           width: 290,
//                           height: 53,
//                           padding: EdgeInsets.symmetric(horizontal: 16),
//                           child: reusableTextField(
//                               "اسم الحرفي",
//                               Icons.person_outline,
//                               false,
//                               _nameTextEditingController),
//                         ),

//                         SizedBox(
//                           height: 20,
//                         ),

//                         Container(
//                           width: 290,
//                           height: 53,
//                           padding: EdgeInsets.symmetric(horizontal: 16),
//                           child: reusableTextField(
//                               "البريد الإلكتروني",
//                               Icons.email_rounded,
//                               false,
//                               _emailTextEditingController),
//                         ),

//                         SizedBox(
//                           height: 23,
//                         ),

//                         Container(
//                           width: 290,
//                           height: 53,
//                           padding: EdgeInsets.symmetric(horizontal: 16),
//                           child: reusableTextField("الرقم السري", Icons.lock,
//                               true, _passwordTextController),
//                         ),

//                         SizedBox(
//                           height: 17,
//                         ),

//                         // GestureDetector(
//                         //   onTap: () async {
//                         //     DateTime? newDate = await showDatePicker(
//                         //         context: context,
//                         //         initialDate: date,
//                         //         firstDate: DateTime(2007),
//                         //         lastDate: DateTime(2017));

//                         //     //if cancelled
//                         //     if (newDate == null) return;
//                         //     //if not null
//                         //     setState(() => date = newDate);
//                         //   },
//                         //   child: Container(
//                         //       child: Padding(
//                         //     padding: const EdgeInsets.all(30.0),
//                         //     child: TextField(
//                         //       controller: _dateController,
//                         //       decoration: const InputDecoration(
//                         //         icon: Icon(Icons.calendar_today_rounded),
//                         //         labelText: ' تاريخ الميلاد',
//                         //       ),
//                         //     ),
//                         //   )),
//                         // ),
//                         // ElevatedButton(
//                         //   child: Text('أدخل تاريخ الميلاد'),
//                         //   onPressed: () async {
//                         //     DateTime? newDate = await showDatePicker(
//                         //         context: context,
//                         //         initialDate: date,
//                         //         firstDate: DateTime(2007),
//                         //         lastDate: DateTime(2017));

//                         //     //if cancelled
//                         //     if (newDate == null) return;
//                         //     //if not null
//                         //     setState(() => date = newDate);
//                         //   },
//                         // ),
//                         Container(
//                           width: 290,
//                           height: 53,
//                           padding: EdgeInsets.symmetric(horizontal: 16),
//                           child: TextField(

//                             controller: _textEditingController,
//                             onTap: () {
//                               _selectDate(context);
//                             },
//                           ),
//                         ),
//                         SizedBox(
//                           height: 17,
//                         ),

//                         Container(
//                           width: 290,
//                           height: 53,
//                           padding: EdgeInsets.symmetric(horizontal: 16),
//                           child: reusableTextField(
//                               "رقم الجوال",
//                               Icons.phone_android,
//                               false,
//                               _PhoneNumberTextEditingController),
//                         ),

//                         SizedBox(
//                           height: 17,
//                         ),
//                         Text("!هيا لتبدأ رحلتك"),
//                         SizedBox(
//                           height: 6,
//                         ),
//                         ElevatedButton(
//                           onPressed: () {},
//                           style: ButtonStyle(
//                             backgroundColor:
//                                 MaterialStateProperty.all(Colors.blue),
//                             padding: MaterialStateProperty.all(
//                                 EdgeInsets.symmetric(
//                                     horizontal: 89, vertical: 10)),
//                             shape: MaterialStateProperty.all(
//                                 RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(27))),
//                           ),
//                           child: Text(
//                             "سجل الحساب",
//                             style: TextStyle(fontSize: 24),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 33,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             TextButton(
//                               child: Text(
//                                 " تسجيل الدخول",
//                                 style: TextStyle(
//                                   decoration: TextDecoration.underline,
//                                 ),
//                               ),
//                               onPressed: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => const TestLogin()),
//                                 );
//                               },
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.pushNamed(context, "/login");
//                               },
//                               child: Text(
//                                 " هل لديك حساب بالفعل؟",
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 17,
//                         ),
//                       ], //children
//                     ), //col
//                   ), //SizedBox
//                 ], //children
//               ), //stack
//             ), //sized box
//           ), //scaffold
        ),
      ),
    ); //form
  }
Widget imageProfile() {
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
          radius: 80.0,
          backgroundImage: _imageFile == null
              ? AssetImage("assets/images/Circular_Logo.png") as ImageProvider
              : FileImage(File(_imageFile!.path)),
          //images\Circular_Logo.png
          // _imageFile.path
          //
          // ?  as ImageProvider
          // :
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
            child: Icon(
              Icons.camera_alt,
              color: Colors.teal,
              size: 28.0,
            ),
          ),
        ),
      ]),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(   
        children: <Widget>[
          Text(
            "اختر صورة",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: Text("الكاميرا"),
            ),
            TextButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: Text("الصور"),
            ),
          ])
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      try {
        _imageFile = pickedFile!;
      } catch (e) {
        Fluttertoast.showToast(
          msg: 'هناك مشكلة أعد ادخال الصوره مجددا',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.white,
          textColor: Colors.red,
          fontSize: 18.0,
        );
      }
    });
  }
}
      

//get image from user

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