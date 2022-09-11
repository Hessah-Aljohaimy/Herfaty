import 'package:flutter/material.dart';

TextFormField reusableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextFormField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    style: TextStyle(color: Color.fromARGB(106, 26, 96, 91)),
    
    decoration: InputDecoration(

      contentPadding: const EdgeInsets.symmetric(vertical: 1.0,horizontal: 23),
      suffix: Icon(
        icon,
        color: Color.fromARGB(255, 26, 96, 91),
      ),
      labelText: text,
      labelStyle: TextStyle(color: Color.fromARGB(255, 26, 96, 91)),
      // floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white.withOpacity(0.3),

      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromARGB(255, 26, 96, 91)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide:
            BorderSide(width: 2, color: Color.fromARGB(255, 26, 96, 91)),
      ),

 errorStyle: TextStyle(color: Color.fromARGB(255, 164, 46, 46)),
                              
                                 errorBorder:  OutlineInputBorder(

                                borderSide: BorderSide( color: Color.fromARGB(255, 164, 46, 46)   ), 
                            


                                 ), 

focusedErrorBorder:  OutlineInputBorder(
                                 borderSide: BorderSide(  width: 2,color: Color.fromARGB(255, 164, 46, 46)),
                                 ),



    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "أدخل " + text;
      }

      if (text == "البريد الإلكتروني" &&
          !RegExp(r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$")
              .hasMatch(value) &&
          !isPasswordType) {
        return 'أدخل بريد إلكتروني صحيح';
      }

      if (text == "كلمة المرور") {
        if (value.length < 6) return "كلمة المرور يجب أن لا تقل عن 6 خانات";
      }
      if (text == "تاريخ الميلاد") {
        return "  yyyy/mm/dd ادخل تاريخ الميلاد ";
      }

      return null;
    },
  );
}

Container firebaseUIButton(BuildContext context, String title, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.black26;
            }
            return Colors.white;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
    ),
  );
}
