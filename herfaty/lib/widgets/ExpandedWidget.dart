import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class ExpandedWidget extends StatefulWidget {
  final String text;
  const ExpandedWidget({super.key, required this.text});

  @override
  State<ExpandedWidget> createState() => _ExpandedWidgetState();
}

class _ExpandedWidgetState extends State<ExpandedWidget> {
  late String firstHalf;
  late String secondHalf;
  bool flag = true;

  @override
  Widget build(BuildContext context) {
    if (widget.text.length > 88) {
      firstHalf = widget.text.substring(0, 88);
      secondHalf = widget.text.substring(89, widget.text.length);
      return expandingMethod();
    } else {
      firstHalf = widget.text;
      secondHalf = "";
      return shortTextMethod();
    }
  }

  Container shortTextMethod() {
    return Container(
      padding: EdgeInsets.only(bottom: 17),
      child: Text(
        widget.text,
        style: TextStyle(
          fontSize: 17,
          height: 1.4,
          fontWeight: FontWeight.w500,
          color: Colors.white,
          fontFamily: "Tajawal",
        ),
      ),
    );
  }

  Container expandingMethod() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            flag ? firstHalf : widget.text,
            style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.w500,
              height: 1.4,
              fontFamily: "Tajawal",
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          InkWell(
            onTap: () {
              setState(() {
                flag = !flag;
                //كل مرة نضغط عليه تتغير قيمته بحيث لو النص مختفي يظهره لو ظاهر يخفيه
              });
            },
            child: Row(
              children: [
                const Text(
                  "تكملة الوصف",
                  style: TextStyle(
                    fontSize: 13.0,
                    fontFamily: "Tajawal",
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 0, 66, 116),
                  ),
                ),
                Icon(
                  flag ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
                  color: Color.fromARGB(255, 0, 66, 116),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
