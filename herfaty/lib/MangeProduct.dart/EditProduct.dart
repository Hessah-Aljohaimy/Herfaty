import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:herfaty/firestore/firestore.dart';
import 'package:herfaty/models/product.dart';
import 'package:herfaty/screens/ownerProductsCateg.dart';
import 'package:image_picker/image_picker.dart'; //there
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

import '../OwnerProducts/OwnerProductsList.dart';
import '../constants/color.dart';
import '../models/shopOwnerModel.dart';

//import 'constants/color.dart';
//import 'package:herfaty/MangeProduct.dart/models/shopOwnerModel.dart';
class EditProduct extends StatefulWidget {
  const EditProduct(
    this.avalibleAmount,
    this.categoryName,
    this.dsscription,
    this.image,
    this.name,
    this.price,
  );
  final String avalibleAmount;
  final String categoryName;
  final String dsscription;
  final String image;
  final String name;
  final String price;

  @override
  State<EditProduct> createState() => _EditProduc();
}

class _EditProduc extends State<EditProduct> {
  final _formKey = GlobalKey<FormState>(); //To validate form

  // Initial Selected Value
  String dropdownvalue = 'فنون الورق والتلوين'; // default value
  // List of items in our dropdown menu
  var items = [
    'فنون الورق والتلوين',
    'الخرز والإكسسوار',
    'الفخاريات',
    'الحياكة والتطريز',
  ];

//Text controllers
  late TextEditingController nameController = TextEditingController()
    ..text = widget.name;
  late var descController = TextEditingController()..text = widget.dsscription;
  late var amountController = TextEditingController()..text = widget.price;
  var priceController = TextEditingController();
  // initilazie Image Picker library
  final ImagePicker _picker = ImagePicker();
  var uploadImageUrl = ""; //image URL before choose pic
  // Firebase storage + ref for pic place
  final storageRef = FirebaseStorage.instance.ref();

  Widget build(BuildContext context) {
    //////////////////////////////////////////////////////////////////////////////////////////
    ///
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    String thisOwnerId = user!.uid;
    var shopNameData;

    Stream<List<shopOwnerModel>> shopOwnerData() {
      // final uid = user.getIdToken();

      final user;
      user = FirebaseAuth.instance.currentUser;
      final uid = user.uid;
      return FirebaseFirestore.instance
          .collection('shop_owner')
          .where('id', isEqualTo: uid)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => shopOwnerModel.fromJson(doc.data()))
              .toList());
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: Container(
          child: const DefaultAppBar(title: " تعديل المنتج "),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            //can doing scroll

            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Container(
                //margin: EdgeInsets.symmetric(horizontal: 200),
                child: SizedBox(
                  width: 300,
                  height: 40,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      await _showMyDialog();
                    },

                    style: ElevatedButton.styleFrom(primary: kPrimaryColor),
                    icon: Icon(
                      // <-- Icon
                      Icons.image,
                      size: 24.0,
                    ),

                    label: Text(
                      'إرفاق صورة',
                      style: TextStyle(fontSize: 22, fontFamily: "Tajawal"),
                      //textAlign: TextAlign.right,
                    ), // <-- Text
                  ),
                ),
              ),
              StreamBuilder<List<shopOwnerModel>>(
                  stream: shopOwnerData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Text('Something went wrong! ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      final cItems = snapshot.data!.toList();

                      for (int i = 0; i < cItems.length; i++) {
                        shopNameData = cItems[i].shopname;
                      }
                    }
                    return Text('');
                  }),

              SizedBox(
                height: 20,
              ),
              if (uploadImageUrl.isEmpty)
                SizedBox()
              else
                Image.network(
                  uploadImageUrl,
                  width: 200,
                  height: 200,
                ),
              SizedBox(
                height: 20,
              ),
              Row(
                //
                mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly, //for right edge
                children: [
                  SizedBox(width: 20), // for space
                  Text(
                    'فئة المنتج',
                    style: TextStyle(fontSize: 21, fontFamily: "Tajawal"),
                  ),

                  DropdownButton(
                    // Initial Value
                    value: dropdownvalue,
                    underline: Container(
                      height: 3,
                      color: kPrimaryColor, //<-- SEE HERE
                    ),
                    icon: Icon(Icons.arrow_drop_down),
                    style: const TextStyle(
                        color: kPrimaryColor, //<-- SEE HERE
                        fontSize: 19,
                        fontWeight: FontWeight.bold),
                    // Down Arrow Icon
                    // Array list of items
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(
                          items,
                        ),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),
                ],
              ),
              /* DropdownButton(
                // Initial Value
                value: dropdownvalueNumber,
                underline: Container(
                  height: 3,
                  color: Color.fromARGB(255, 26, 96, 91), //<-- SEE HERE
                ),
                icon: Icon(Icons.arrow_drop_down),
                style: const TextStyle(
                    color: Color.fromARGB(255, 26, 96, 91), //<-- SEE HERE
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                // Down Arrow Icon
                // Array list of items
                items: numberitems.map((var items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(
                      items,
                      textAlign: TextAlign.right,
                    ),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (var? newValue) {
                  setState(() {
                    dropdownvalueNumber = newValue!;
                  });
                },
              ),*/

              SizedBox(
                height: 40,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  controller: nameController,
                  //right aligment

                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'اسم المنتج',
                    hintStyle: TextStyle(fontSize: 18, fontFamily: "Tajawal"),
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Icon(Icons.production_quantity_limits_sharp,
                          color: kPrimaryColor),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 3.0, horizontal: 23),
                    labelStyle:
                        TextStyle(color: kPrimaryColor, fontFamily: "Tajawal"),
                    // floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Colors.white.withOpacity(0.3),

                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: kPrimaryColor),
                    ),
                    errorStyle:
                        TextStyle(color: Color.fromARGB(255, 164, 46, 46)),

                    errorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 164, 46, 46)),
                    ),

                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2, color: Color.fromARGB(255, 164, 46, 46)),
                    ),
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'أدخل اسم المنتج';
                    }
                    if (!RegExp(
                            r"^[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z ]+[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z- ][]*$")
                        .hasMatch(value)) {
                      return "أدخل اسم بلا أرقام ورموز";
                    }
                    if (value.length < 2) {
                      return " أدخل اسم أكبر من أو يساوي حرفين ";
                    }
                    return null;
                  },
                ),
              ),
              /*Container(
                child: Text(
                  "اسم صحيح بلا أرقام ورموز",
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Color.fromARGB(255, 235, 47, 26)),
                ),
              ),*/

              SizedBox(
                height: 20,
              ), //for space
              Container(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  controller: descController,
                  textAlign: TextAlign.right,
                  maxLength: 300,
                  decoration: InputDecoration(
                    hintText: 'تفاصيل المنتج',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 3.0, horizontal: 23),

                    hintStyle: TextStyle(fontSize: 18, fontFamily: "Tajawal"),
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Icon(Icons.description, //Sara edits
                          color: kPrimaryColor),
                    ),
                    labelStyle:
                        TextStyle(color: kPrimaryColor, fontFamily: "Tajawal"),
                    // floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Colors.white.withOpacity(0.3),

                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: kPrimaryColor),
                    ),
                    errorStyle:
                        TextStyle(color: Color.fromARGB(255, 164, 46, 46)),

                    errorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 164, 46, 46)),
                    ),

                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2, color: Color.fromARGB(255, 164, 46, 46)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'أدخل وصف المنتج';
                    }
                    if (value.length < 2) {
                      return " أدخل وصف أكبر من أو يساوي حرفين ";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'الكمية المتاحة',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 3.0, horizontal: 23),

                    hintStyle: TextStyle(fontSize: 18, fontFamily: "Tajawal"),
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Icon(Icons.numbers,
                          //Sara edits
                          color: kPrimaryColor),
                    ),
                    labelStyle:
                        TextStyle(color: kPrimaryColor, fontFamily: "Tajawal"),
                    // floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Colors.white.withOpacity(0.3),

                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: kPrimaryColor),
                    ),
                    errorStyle:
                        TextStyle(color: Color.fromARGB(255, 164, 46, 46)),

                    errorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 164, 46, 46)),
                    ),

                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2, color: Color.fromARGB(255, 164, 46, 46)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'أدخل كمية المنتج';
                    if (int.parse(value) <= 0) return "أدخل رقم أكبر من صفر";
                    if (int.parse(value) > 15)
                      return "أدخل رقم أصغر من أو يساوي 15";
                    else
                      return null;
                  },
                ),
              ),
              /*  Container(
                padding: const EdgeInsets.only(right: 41),
                child: Text(
                  " *الكمية المتاحة يجب أن تكون بين 1-15",
                  style: TextStyle(color: gray),
                ),
              ),*/
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: 'السعر',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 3.0, horizontal: 23),

                    hintStyle: TextStyle(fontSize: 18, fontFamily: "Tajawal"),
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Icon(Icons.attach_money_outlined,
                          //Sara edits
                          color: kPrimaryColor),
                    ),
                    labelStyle:
                        TextStyle(color: kPrimaryColor, fontFamily: "Tajawal"),
                    // floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Colors.white.withOpacity(0.3),

                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: kPrimaryColor),
                    ),
                    errorStyle:
                        TextStyle(color: Color.fromARGB(255, 164, 46, 46)),

                    errorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 164, 46, 46)),
                    ),

                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2, color: Color.fromARGB(255, 164, 46, 46)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'أدخل السعر ';
                    else if (int.parse(value!) <= 0)
                      return "أدخل رقم أكبر من صفر";
                    else
                      return null;
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),

              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (uploadImageUrl.isEmpty)
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('الرجاء إرفاق صورة')));
                  /*if (uploadImageUrl.isEmpty &&
                      _formKey.currentState.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('الرجاء إرفاق صورة')));
                    _showMyDialog();
                  }*/

                  if (_formKey.currentState!.validate() &&
                      uploadImageUrl != "") {
                    String prodName = nameController.text;
                    String desc = descController.text;
                    int amount = int.parse(amountController.text);
                    double priceN = double.parse(priceController.text);

                    /*

                    final user;
                    user = FirebaseAuth.instance.currentUser;
                    final uid = user.uid;

                    FirebaseFirestore.instance
                        .collection("users")
                        .where("email", isEqualTo: uid)
                        .snapshots()
                        .map((snapshot) =>
                        snapshot.docs.map((doc) => CartModal.fromJson(doc.data())).toList());*/

                    final productToBeAdded =
                        FirebaseFirestore.instance.collection('Products').doc();
                    Product product = Product(
                        id: productToBeAdded.id,
                        name: prodName,
                        dsscription: desc,
                        avalibleAmount: amount,
                        image: uploadImageUrl,
                        categoryName: dropdownvalue,
                        price: priceN,
                        shopOwnerId: thisOwnerId,
                        shopName: shopNameData);
                    final json = product.toJson();
                    await productToBeAdded.set(json);
                    //await Firestore.saveProduct(product);
                    Fluttertoast.showToast(
                      msg: "تم تعديل المنتج بنجاح",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 3,
                      backgroundColor: Color.fromARGB(255, 26, 96, 91),
                      textColor: Colors.white,
                      fontSize: 18.0,
                    );
                    await Future.delayed(const Duration(seconds: 1), () {
                      Navigator.pop(context);
                    });

                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   const SnackBar(content: Text('تم حفظ المنتج')),
                    // );
                  }
                  /*   nameController.clear();
                  descController.clear();
                  amountController.clear();
                  priceController.clear();*/
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xff51908E)),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 40, vertical: 13)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27))),
                ),
                child: Text(
                  "تعديل المنتج",
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Tajawal",
                      fontWeight: FontWeight.bold),
                ),
              ),
              /* child: Text("إضافة منتج"),
                style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 26, 96, 91)),
              ),*/

              SizedBox(
                height: 20,
              ),

              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 167, 29, 29)),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 40, vertical: 13)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27))),
                ),
                child: Text(
                  "إلغاء",
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Tajawal",
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("تنبيه"),
                          content: Text('سيتم إلغاء حفظ التعديلات'),
                          actions: <Widget>[
                            TextButton(
                              child: Text(" تأكيد",
                                  style: TextStyle(color: Colors.red)),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ownerProductsCategScreen()),
                                );
                              },
                            ),
                            TextButton(
                              child: Text("تراجع"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      });
                },
              ),
              /* ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.red),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("إلغاء "),
              ),*/
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'إرفاق صورة',
            textAlign: TextAlign.right,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'من ألبوم الصور',
                textAlign: TextAlign.right,
              ),
              onPressed: () async {
                // Pick an image
                final XFile? photo =
                    await _picker.pickImage(source: ImageSource.gallery);
                try {
                  final file = File(photo!.path);
                  uploadImageToFirebaseStorage(file);
                } catch (e) {
                  print("error");
                }
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                "من الكاميرا",
                textAlign: TextAlign.right,
              ),
              onPressed: () async {
                // Capture a photo
                final XFile? photo =
                    await _picker.pickImage(source: ImageSource.camera);

                final file = File(photo!.path);
                uploadImageToFirebaseStorage(file);
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  void uploadImageToFirebaseStorage(File file) async {
    // Create a reference to 'images/mountains.jpg'
    final imagesRef =
        storageRef.child("images/${DateTime.now().millisecondsSinceEpoch}.png");
    await imagesRef.putFile(file);

    uploadImageUrl = await imagesRef.getDownloadURL();
    setState(() {});
    print("uploaded:" + uploadImageUrl);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('nameController', nameController));
  }
} //class

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
      title: Text(title,
          style: TextStyle(color: kPrimaryColor, fontFamily: "Tajawal")),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      iconTheme: IconThemeData(color: kPrimaryColor),
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => OwnerProductsList(
                    categoryName: null,
                  )));
        },
        icon: Icon(Icons.arrow_back),
      ),
    );
  }
}
