import 'package:flutter/material.dart';
import 'package:herfaty/test_Login.dart';
import 'package:herfaty/reusable_widgits.dart';
import 'package:herfaty/welcomeRegestration.dart';

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

  TextEditingController _PhoneNumberTextEditingController =
      TextEditingController();

  TextEditingController _shopnameTextEditingController =
      TextEditingController();
  TextEditingController _shoplogoEditingController = TextEditingController();

  TextEditingController _shopdescriptionTextEditingController =
      TextEditingController();

  List<Step> stepList() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: Text('معلومات الحرفي'),
          content: Column(
            children: <Widget>[
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
                height: 20,
              ),

              Container(
                  child: Image.asset(
                "assets/images/HerfatyLogoCroped.png",
                height: 120,
              )),
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
                width: 290,
                height: 53,
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: reusableTextField("اسم الحرفي", Icons.person,
                    false, _nameTextEditingController),
              ),

              SizedBox(
                height: 20,
              ),

              Container(
                width: 290,
                height: 53,
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: reusableTextField("البريد الإلكتروني",
                    Icons.email_rounded, false, _emailTextEditingController),
              ),

              SizedBox(
                height: 23,
              ),

              Container(
                width: 290,
                height: 53,
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: reusableTextField(
                    "كلمة المرور", Icons.lock, true, _passwordTextController),
              ),

              SizedBox(
                height: 17,
              ),

              Container(
                width: 290,
                height: 53,
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: reusableTextField("عمر الطفل",
                    Icons.calendar_today_rounded, false, _dateController),
              ),
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
                width: 290,
                height: 53,
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: reusableTextField("رقم الجوال", Icons.phone_android,
                    false, _PhoneNumberTextEditingController),
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

////////////////////////////Importing Picture //////////////////////////////////

                Container(
                  width: 290,
                  height: 53,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: reusableTextField("اسم المتجر", Icons.shop, false,
                      _shopnameTextEditingController),
                ),

                SizedBox(
                  height: 20,
                ),

                Container(
                  width: 290,
                  height: 53,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: reusableTextField("وصف المتجر", Icons.shop_2, false,
                      _shopdescriptionTextEditingController),
                ),

                SizedBox(
                  height: 17,
                ),

                SizedBox(
                  height: 17,
                ),
                Text("!هيا لتبدأ رحلتك"),
                SizedBox(
                  height: 6,
                ),
                ElevatedButton(
                  onPressed: () {
//1 Authentication

//2 Routing
                    Navigator.of(context).pushNamed("test_Login");
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 26, 96, 91)),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 89, vertical: 10)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
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
                      ),
                    ),
                    TextButton(
                      child: Text(
                        " تسجيل الدخول",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TestLogin()),
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
                            Color.fromARGB(255, 26, 96, 91)),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 89, vertical: 10)),
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
                            EdgeInsets.symmetric(horizontal: 89, vertical: 10)),
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

  _selectDate(BuildContext context) async {
//   DateTime newSelectedDate = await showDatePicker(
// // context: context,
// initialDate:  _selectedDate,
// firstDate: DateTime(2007),
// lastDate: DateTime(2017)),
// builder: (BuildContext context, Widget child) {
// return Theme(
//             data: ThemeData.dark().copyWith(
//               colorScheme: ColorScheme.dark(
//                 primary: Color.fromARGB(255, 26, 96, 91),
//                 onPrimary: Colors.white,
//                 surface: Colors.blueGrey,
//                 onSurface: Colors.black,
//               ),
//               dialogBackgroundColor: Colors.white,
//             ),
//             child: child,
//           );
//         }

//     if (newSelectedDate != null) {
//       _selectedDate = newSelectedDate;
//       _textEditingController
//         ..text = DateFormat.yMMMd().format(_selectedDate)
//         ..selection = TextSelection.fromPosition(TextPosition(
//             offset: _textEditingController.text.length,
//             affinity: TextAffinity.upstream));
//     }
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
