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
    if (widget.text.length > 66) {
      firstHalf = widget.text.substring(0, 66);
      secondHalf = widget.text.substring(67, widget.text.length);
      return expandingMethod();
    } else {
      firstHalf = widget.text;
      secondHalf = "";
      return shortTextMethod();
    }
  }

  Container shortTextMethod() {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: Text(
        widget.text,
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.white,
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
              fontSize: 18.0,
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
                    fontSize: 16.0,
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
