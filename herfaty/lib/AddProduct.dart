import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:herfaty/firestore/firestore.dart';
import 'package:herfaty/models/product.dart';
import 'package:image_picker/image_picker.dart'; //there
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>(); //To validate form

  // Initial Selected Value
  String dropdownvalue = 'الرسم والتلوين'; // default value
  // List of items in our dropdown menu
  var items = [
    'الرسم والتلوين',
    'الخرز والإكسسوار',
    'الفخاريات',
    'الحياكة والتطريز',
  ];

//Text controllers
  var nameController = TextEditingController();
  var descController = TextEditingController();
  var amountController = TextEditingController();
  var priceController = TextEditingController();

  // initilazie Image Picker library
  final ImagePicker _picker = ImagePicker();
  var uploadImageUrl = ""; //image URL before choose pic
  // Firebase storage + ref for pic place
  final storageRef = FirebaseStorage.instance.ref();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
            alignment: Alignment.centerRight,
            child:
                Text("إضافة منتج", style: TextStyle(color: Color(0xff51908E)))),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            //can doing scroll

            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 100),
                child: ElevatedButton.icon(
                  onPressed: () async {
                    await _showMyDialog();
                  },
                  style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 26, 96, 91)),
                  icon: Icon(
                    // <-- Icon
                    Icons.image,
                    size: 24.0,
                  ),
                  label: Text(
                    'إرفاق صورة',
                    style: TextStyle(fontSize: 22),
                    textAlign: TextAlign.right,
                  ), // <-- Text
                ),
              ),
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

              Row(
                //
                mainAxisAlignment: MainAxisAlignment.end, //for right edge
                children: [
                  DropdownButton(
                    // Initial Value
                    value: dropdownvalue,
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
                    items: items.map((String items) {
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
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),

                  SizedBox(width: 20), // for space
                  Text(
                    'فئة المنتج',
                    style: TextStyle(fontSize: 22),
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
                height: 20,
              ),
              TextFormField(
                controller: nameController,
                textAlign: TextAlign.right, //right aligment
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'اسم المنتج',
                  hintStyle: TextStyle(fontSize: 19),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Icon(
                        Icons
                            .production_quantity_limits_sharp, //sara rdits from here
                        color: Color.fromARGB(255, 26, 96, 91)),
                  ),
                  labelStyle: TextStyle(
                      color: Color.fromARGB(255, 26, 96, 91),
                      fontFamily: "Tajawal"),
                  // floatingLabelBehavior: FloatingLabelBehavior.never,
                  fillColor: Colors.white.withOpacity(0.3),

                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 26, 96, 91)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2, color: Color.fromARGB(255, 26, 96, 91)),
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
                  } else if (!RegExp(
                          r"^[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z ]+[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z- ][]*$")
                      .hasMatch(value)) {
                    return "أدخل اسم بلا أرقام ورموز";
                  } else if (value.length < 2) {
                    return " أدخل اسم أكبر من أو يساوي حرفين ";
                  }
                  return null;
                },
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

              TextFormField(
                maxLines: null,
                keyboardType: TextInputType.multiline,
                controller: descController,
                textAlign: TextAlign.right,
                maxLength: 300,
                decoration: InputDecoration(
                  hintText: 'تفاصيل المنتج',
                  hintStyle: TextStyle(fontSize: 19),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Icon(Icons.description, //Sara edits
                        color: Color.fromARGB(255, 26, 96, 91)),
                  ),
                  labelStyle: TextStyle(
                      color: Color.fromARGB(255, 26, 96, 91),
                      fontFamily: "Tajawal"),
                  // floatingLabelBehavior: FloatingLabelBehavior.never,
                  fillColor: Colors.white.withOpacity(0.3),

                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 26, 96, 91)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2, color: Color.fromARGB(255, 26, 96, 91)),
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
                  } else if (value.length < 2) {
                    return " أدخل وصف أكبر من أو يساوي حرفين ";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),

              TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'الكمية المتاحة',

                  hintStyle: TextStyle(fontSize: 19),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Icon(Icons.numbers,
                        //Sara edits
                        color: Color.fromARGB(255, 26, 96, 91)),
                  ),
                  labelStyle: TextStyle(
                      color: Color.fromARGB(255, 26, 96, 91),
                      fontFamily: "Tajawal"),
                  // floatingLabelBehavior: FloatingLabelBehavior.never,
                  fillColor: Colors.white.withOpacity(0.3),

                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 26, 96, 91)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2, color: Color.fromARGB(255, 26, 96, 91)),
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
                  else if (int.parse(value) <= 0)
                    return "أدخل رقم أكبر من صفر";
                  else if (int.parse(value) > 15)
                    return "أدخل رقم أصغر من أو يساوي 15";
                  else
                    return null;
                },
              ),
              Container(
                child: Text(
                  "الكمية المتاحة يجب أن تكون بين 1-15",
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Color.fromARGB(255, 235, 47, 26)),
                ),
              ),

              SizedBox(
                height: 20,
              ),

              TextFormField(
                controller: priceController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: 'السعر',
                  hintStyle: TextStyle(fontSize: 19),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Icon(Icons.attach_money_outlined,
                        //Sara edits
                        color: Color.fromARGB(255, 26, 96, 91)),
                  ),
                  labelStyle: TextStyle(
                      color: Color.fromARGB(255, 26, 96, 91),
                      fontFamily: "Tajawal"),
                  // floatingLabelBehavior: FloatingLabelBehavior.never,
                  fillColor: Colors.white.withOpacity(0.3),

                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 26, 96, 91)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2, color: Color.fromARGB(255, 26, 96, 91)),
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
                    double priceN = double.parse(amountController.text);

                    Product product = Product(
                        name: prodName,
                        dsscription: desc,
                        avalibleAmount: amount,
                        image: uploadImageUrl,
                        categoryName: dropdownvalue,
                        price: priceN);

                    await Firestore.saveProduct(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تم حفظ المنتج')),
                    );
                  }
                  /*   nameController.clear();
                  descController.clear();
                  amountController.clear();
                  priceController.clear();*/
                },
                child: Text(
                  "إضافة منتج",
                  style: TextStyle(fontSize: 22),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 35, 125, 118)),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 90, vertical: 13)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27))),
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
                      EdgeInsets.symmetric(horizontal: 90, vertical: 13)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27))),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "إلغاء ",
                  style: TextStyle(fontSize: 22),
                ),
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
}

/*Container(
                        
                        // decoration: BoxDecoration(
                          
                        //   color: Color.fromARGB(255, 114, 159, 160),
                        //   borderRadius: BorderRadius.circular(66),
                          
                        // ),
                      //  width: 290,
                      //   height: 53,
                        padding: EdgeInsets.symmetric(horizontal: 60),
                        child:*/
