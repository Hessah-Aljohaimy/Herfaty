import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:herfaty/constants/color.dart';
import 'package:herfaty/constants/cartItems.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        appBar: DefaultAppBar(title: "سلتي"),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Add your onPressed code here!
          },
          label: const Text('دفع'),
          icon: const Icon(Icons.payment),
          backgroundColor: Color(0xff5596A5),
          extendedPadding: EdgeInsetsDirectional.only(start: 50.0, end: 50.0),
        ),
        body: Center(
          child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFF1F1F1))),
                  child: Row(
                    children: [
                      Image(
                        image: AssetImage(cartItems[index].image),
                        height: 110.0,
                        width: 110.0,
                        fit: BoxFit.cover,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(cartItems[index].title,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 16.0)),
                              Text("\$ ${cartItems[index].price.toString()}"),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (cartItems[index].quantity > 0) {
                                            cartItems[index].quantity--;
                                          }
                                        });
                                      },
                                      icon: Icon(
                                        Icons.remove_circle_outline,
                                        color: kPrimaryColor,
                                      )),
                                  Container(
                                      width: 44.0,
                                      height: 44.0,
                                      padding: EdgeInsets.only(top: 22.0),
                                      color: Color(0xFFF1F1F1),
                                      child: TextField(
                                        enabled: false,
                                        textAlign: TextAlign.center,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: cartItems[index]
                                                .quantity
                                                .toString(),
                                            hintStyle: TextStyle(
                                                color: Color(0xFF303030))),
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          // Max 5
                                          if (cartItems[index].quantity <= 4) {
                                            cartItems[index].quantity++;
                                          }
                                        });
                                      },
                                      icon: Icon(
                                        Icons.add_circle_outline,
                                        color: kPrimaryColor,
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),

        /*body: Column(
          children: const [
            //AppBarc(),
            Bodyc(),
          ],
        ),*/
      ),
    );
  }
}

/*
class AppBarc extends StatelessWidget {
  const AppBarc({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("سلتي", style: TextStyle(color: kPrimaryColor)),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      iconTheme: IconThemeData(color: kPrimaryColor),
    );
  }
}*/

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const DefaultAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(56.0);
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: TextStyle(color: kPrimaryColor)),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      iconTheme: IconThemeData(color: kPrimaryColor),
    );
  }
}




/*
class Bodyc extends StatefulWidget {
  const Bodyc({Key? key}) : super(key: key);

  @override
  _BodycState createState() => _BodycState();
}

class _BodycState extends State<Bodyc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                padding: EdgeInsets.all(8.0),
                decoration:
                    BoxDecoration(border: Border.all(color: Color(0xFFF1F1F1))),
                child: Row(
                  children: [
                    Image(
                      image: AssetImage(cartItems[index].image),
                      height: 110.0,
                      width: 110.0,
                      fit: BoxFit.cover,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(cartItems[index].title,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 16.0)),
                            Text("\$ ${cartItems[index].price.toString()}"),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (cartItems[index].quantity > 0) {
                                          cartItems[index].quantity--;
                                        }
                                      });
                                    },
                                    icon: Icon(
                                      Icons.remove_circle_outline,
                                      color: kPrimaryColor,
                                    )),
                                Container(
                                    width: 44.0,
                                    height: 44.0,
                                    padding: EdgeInsets.only(top: 22.0),
                                    color: Color(0xFFF1F1F1),
                                    child: TextField(
                                      enabled: false,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: cartItems[index]
                                              .quantity
                                              .toString(),
                                          hintStyle: TextStyle(
                                              color: Color(0xFF303030))),
                                    )),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        // Max 5
                                        if (cartItems[index].quantity <= 4) {
                                          cartItems[index].quantity++;
                                        }
                                      });
                                    },
                                    icon: Icon(
                                      Icons.add_circle_outline,
                                      color: kPrimaryColor,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
*/