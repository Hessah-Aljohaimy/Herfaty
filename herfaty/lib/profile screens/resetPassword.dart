import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:herfaty/widgets/ownerSettings.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController _oldPasswordTextController =
      new TextEditingController();
  TextEditingController _newPasswordTextController1 =
      new TextEditingController();
  TextEditingController _newPasswordTextController2 =
      new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("إعادة تعيين كلمة المرور",
            style: TextStyle(color: Color(0xff51908E))),
        centerTitle: true,
        backgroundColor: Colors.white,
        shadowColor: Color.fromARGB(255, 39, 141, 134),
        elevation: 3,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => OwnerSettings()));
          },
          icon: Icon(Icons.arrow_back),
        ),
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Color(0xff51908E)),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            width: 430,
            height: 430,
            margin: EdgeInsets.only(top: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 350,
                  child: reusableTextField(
                      'كلمة المرور القديمة', true, _oldPasswordTextController),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  width: 350,
                  child: reusableTextField(
                      'كلمة المرور الجديدة', true, _newPasswordTextController1),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  width: 350,
                  child: reusableTextField(
                      'تأكيد كلمة المرور', true, _newPasswordTextController2),
                ),
                SizedBox(
                  height: 35,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {}
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xff51908E)),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 160, vertical: 13)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(27))),
                  ),
                  child: Text(
                    "حفظ",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Tajawal",
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///Text feild ///
  TextFormField reusableTextField(
      String text, bool isPasswordType, TextEditingController controller) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      obscureText: isPasswordType,
      enableSuggestions: !isPasswordType,
      autocorrect: !isPasswordType,
      keyboardType: isPasswordType
          ? TextInputType.visiblePassword
          : TextInputType.emailAddress,
      style: TextStyle(
          color: Color.fromARGB(255, 90, 90, 90), fontFamily: "Tajawal"),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 1.0, horizontal: 25),
        labelText: text,
        labelStyle: TextStyle(
            color: Color.fromARGB(255, 26, 96, 91),
            fontFamily: "Tajawal",
            fontSize: 20,
            fontWeight: FontWeight.bold),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        fillColor: Colors.white.withOpacity(0.3),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(188, 26, 96, 91),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: Colors.blue),
        ),
        errorStyle: TextStyle(color: Color.fromARGB(255, 164, 46, 46)),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 164, 46, 46)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(width: 3, color: Color.fromARGB(255, 164, 46, 46)),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "أدخل " + text;
        }

        if (text == "كلمة المرور") {
          if (value.length < 6) return "ادخل كلمة مرور اكبر من 6 خانات";
        }
      },
    );
  }
}
