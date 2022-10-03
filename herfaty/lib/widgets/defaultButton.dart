import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final String btnText;
  final Function onPressed;
  const DefaultButton({
    Key? key,
    btnText,
    onPressed,
  })  : this.btnText = btnText,
        this.onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(vertical: 24),
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xff51908E),
            fixedSize: const Size(150, 300),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50))),
        child: Text(btnText.toUpperCase()),
      ),
    );
  }
}
