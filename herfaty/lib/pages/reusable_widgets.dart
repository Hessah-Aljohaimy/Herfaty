import 'package:flutter/material.dart';

TextFormField reusableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextFormField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    minLines: text == "وصف المتجر" ? 1 : 1,
    maxLines: text == "وصف المتجر" ? 9 : 1,
    // maxLength:text=="وصف المتجر"?140:1,
// keyboardType:text=="وصف المتجر"?TextInputType.multiline: TextInputType.none,
// keyboardType: text == "عمر الطفل"? TextInputType.number:TextInputType.none,
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,

    style: TextStyle(
        color: Color.fromARGB(255, 26, 96, 91), fontFamily: "Tajawal"),
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 23),

      suffix: Icon(
        icon,
        color: Color.fromARGB(255, 26, 96, 91),
      ),
      labelText: text,
      labelStyle: TextStyle(
          color: Color.fromARGB(106, 26, 96, 91), fontFamily: "Tajawal"),
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

      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromARGB(255, 164, 46, 46)),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderSide:
            BorderSide(width: 2, color: Color.fromARGB(255, 164, 46, 46)),
      ),
    ),

    validator: (value) {
      if (value == null || value.isEmpty) {
        return "أدخل " + text;
      }
      if (!RegExp(r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$")
              .hasMatch(value) &&
          !isPasswordType &&
          text == 'البريد الإلكتروني' &&
          value.contains(' ')) {
        return 'أدخل بريد إلكتروني صحيح';
      }

      if (text == "كلمة المرور") {
        if (value.length < 6) return "";
      }

      return null;
    },
  );
}

TextFormField reusableTextFieldForPhone(String text, IconData icon,
    bool isPasswordType, TextEditingController controller) {
  return TextFormField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    minLines: text == "وصف المتجر" ? 1 : 1,
    maxLines: text == "وصف المتجر" ? 9 : 1,
    // maxLength:text=="وصف المتجر"?140:1,
// keyboardType:text=="وصف المتجر"?TextInputType.multiline: TextInputType.none,
// keyboardType: text == "عمر الطفل"? TextInputType.number:TextInputType.none,
    keyboardType: TextInputType.phone,

    style: TextStyle(
        color: Color.fromARGB(255, 26, 96, 91), fontFamily: "Tajawal"),
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 23),

      suffix: Icon(
        icon,
        color: Color.fromARGB(255, 26, 96, 91),
      ),
      labelText: text,
      labelStyle: TextStyle(
          color: Color.fromARGB(106, 26, 96, 91), fontFamily: "Tajawal"),
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

      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromARGB(255, 164, 46, 46)),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderSide:
            BorderSide(width: 2, color: Color.fromARGB(255, 164, 46, 46)),
      ),
    ),

    validator: (value) {
      if (value == null || value.isEmpty) {
        return "أدخل " + text;
      }
      if (!RegExp(r"^(009665|9665|\+9665|05|5)(5|0|3|6|4|9|1|8|7)([0-9]{7})$")
              .hasMatch(value) &&
          !isPasswordType) {
        return 'أدخل رقم جوال صحيح';
      }

      return null;
    },
  );
}

TextFormField reusableTextFieldForName(String text, IconData icon,
    bool isPasswordType, TextEditingController controller) {
  return TextFormField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    minLines: text == "وصف المتجر" ? 1 : 1,
    maxLines: text == "وصف المتجر" ? 9 : 1,
    // maxLength:text=="وصف المتجر"?140:1,
// keyboardType:text=="وصف المتجر"?TextInputType.multiline: TextInputType.none,
// keyboardType: text == "عمر الطفل"? TextInputType.number:TextInputType.none,
    keyboardType: TextInputType.name,

    style: TextStyle(
        color: Color.fromARGB(255, 26, 96, 91), fontFamily: "Tajawal"),
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 23),

      suffix: Icon(
        icon,
        color: Color.fromARGB(255, 26, 96, 91),
      ),
      labelText: text,
      labelStyle: TextStyle(
          color: Color.fromARGB(106, 26, 96, 91), fontFamily: "Tajawal"),
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

      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromARGB(255, 164, 46, 46)),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderSide:
            BorderSide(width: 2, color: Color.fromARGB(255, 164, 46, 46)),
      ),
    ),

    validator: (value) {
      if (value == null || value.isEmpty) {
        return "أدخل " + text;
      }
      if (!RegExp(
              r"^[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z ]+[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z- ][]*$")
          .hasMatch(value)) {
        return "أدخل اسم بلا أرقام ورموز";
      }
      if (value.length <= 2 || value.length <= 1) {
        return "أدخل اسم اكبر من حرفين";
      }

      return null;
    },
  );
}

TextFormField reusableTextFieldForAge(String text, IconData icon,
    bool isPasswordType, TextEditingController controller) {
  return TextFormField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    minLines: text == "وصف المتجر" ? 1 : 1,
    maxLines: text == "وصف المتجر" ? 9 : 1,
    keyboardType: TextInputType.number,
    style: TextStyle(
        color: Color.fromARGB(255, 26, 96, 91), fontFamily: "Tajawal"),
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 23),

      suffix: Icon(
        icon,
        color: Color.fromARGB(255, 26, 96, 91),
      ),
      labelText: text,
      labelStyle: TextStyle(
          color: Color.fromARGB(106, 26, 96, 91), fontFamily: "Tajawal"),
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

      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromARGB(255, 164, 46, 46)),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderSide:
            BorderSide(width: 2, color: Color.fromARGB(255, 164, 46, 46)),
      ),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "أدخل " + text;
      }
      // if (!RegExp(r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$")
      //         .hasMatch(value) ) {
      //   return 'أدخل بريد إلكتروني صحيح';
      // }

      // if (text == "كلمة المرور") {
      //   if (value.length < 6) return "";
      // }

      return null;
    },
  );
}

TextFormField reusableTextFieldDec(String text, IconData icon,
    bool isPasswordType, TextEditingController controller) {
  return TextFormField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    minLines: text == "وصف المتجر" ? 1 : 1,
    maxLines: text == "وصف المتجر" ? 9 : 1,
    maxLength: 160,
// keyboardType:text=="وصف المتجر"?TextInputType.multiline: TextInputType.none,
// keyboardType: text == "عمر الطفل"? TextInputType.number:TextInputType.none,
//keyboardType: isPasswordType ? TextInputType.visiblePassword : TextInputType.emailAddress,

    style: TextStyle(
        color: Color.fromARGB(255, 26, 96, 91), fontFamily: "Tajawal"),
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 23),

      suffix: Icon(
        icon,
        color: Color.fromARGB(255, 26, 96, 91),
      ),
      labelText: text,
      labelStyle: TextStyle(
          color: Color.fromARGB(106, 26, 96, 91), fontFamily: "Tajawal"),
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

      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromARGB(255, 164, 46, 46)),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderSide:
            BorderSide(width: 2, color: Color.fromARGB(255, 164, 46, 46)),
      ),
    ),

    validator: (value) {
      if (value == null || value.isEmpty) {
        return "أدخل " + text;
      }
      //  if (!RegExp(
      //                   r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$")
      //               .hasMatch(value)&& !isPasswordType) {
      //             return 'أدخل بريد إلكتروني صحيح';
      //           }

      if (value.length < 6) {
        if (value.length < 6) return "أدخل وصف للمنتج لا يقل عن 6 خانات";
      }

      return null;
    },
  );
}

String? validateEmail(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty) return 'أدخل البريد الإلكتروني';

  return null;
}
