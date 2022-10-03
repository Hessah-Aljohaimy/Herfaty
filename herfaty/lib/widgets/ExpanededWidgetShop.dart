import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ExpandedWidgetShop extends StatefulWidget {
  final String text;
  const ExpandedWidgetShop({super.key, required this.text});

  @override
  State<ExpandedWidgetShop> createState() => _ExpandedWidgetShopState();
}

class _ExpandedWidgetShopState extends State<ExpandedWidgetShop> {
  late String firstHalf;
  late String secondHalf;
  bool flag = true;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > 60) {
      firstHalf = widget.text.substring(0, 60);
      secondHalf = widget.text.substring(61, widget.text.length);
      // return expandingMethod();
    } else {
      firstHalf = widget.text;
      secondHalf = "";
      // return shortTextMethod();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: secondHalf.length == ""
            ? Text(
                widget.text,
                style: TextStyle(
                  fontFamily: "Tajawal",
                  fontSize: 15.0,
                  color: Colors.black,
                ),
              )
            : Text(
                widget.text,
                style: TextStyle(
                  fontFamily: "Tajawal",
                  
                  fontSize: 17.0,
                  color: Colors.black,
                ),
              ));
  }

  // Container expandingMethod() {
  //   return Container(
  //     padding: EdgeInsets.only(bottom: 20),
  //     child: Text(
  //       widget.text,
  //       style: TextStyle(
  //         fontSize: 15.0,
  //         color: Color.fromARGB(255, 0, 0, 0),
  //       ),
  //     ),
  //   );
  // }

  // Container shortTextMethod() {
  //   return Container(
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           flag ? firstHalf : widget.text,
  //           style: TextStyle(
  //             fontSize: 15.0,
  //             color: Color.fromARGB(255, 0, 0, 0),
  //           ),
  //         ),
  //         const SizedBox(
  //           height: 5,
  //         ),
  //         InkWell(
  //           onTap: () {
  //             setState(() {
  //               flag = !flag;
  //               //كل مرة نضغط عليه تتغير قيمته بحيث لو النص مختفي يظهره لو ظاهر يخفيه
  //             });
  //           },
  //           child: Row(
  //             children: [
  //               const Text(
  //                 "تكملة الوصف",
  //                 style: TextStyle(
  //                   fontSize: 13.0,
  //                   decoration: TextDecoration.underline,
  //                   fontWeight: FontWeight.w500,
  //                   color: Color.fromARGB(255, 0, 66, 116),
  //                 ),
  //               ),
  //               Icon(
  //                 flag ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
  //                 color: Color.fromARGB(255, 0, 66, 116),
  //               )
  //             ],
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }
}
