import 'dart:io';

import 'package:flutter/material.dart';
import 'package:herfaty/firestore/firestore.dart';
import 'package:herfaty/models.dart/product.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
  // initilazie Image Picker library
  final ImagePicker _picker = ImagePicker();
  var uploadImageUrl = ""; //image URL before choose pic
  // Firebase storage + ref for pic place
  final storageRef = FirebaseStorage.instance.ref();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          //can doing scroll
          children: <Widget>[
            Row(
              //
              mainAxisAlignment: MainAxisAlignment.end, //for right edge
              children: [
                DropdownButton(
                  // Initial Value
                  value: dropdownvalue,
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
                Text('فئة المنتج'),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: nameController,
              textAlign: TextAlign.right, //right aligment
              decoration: InputDecoration(
                hintText: 'اسم المنتج',
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
                errorStyle: TextStyle(color: Color.fromARGB(255, 164, 46, 46)),

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
                return null;
              },
            ),

            SizedBox(
              height: 20,
            ), //for space

            TextFormField(
              controller: descController,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: 'تفاصيل المنتج',
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
                errorStyle: TextStyle(color: Color.fromARGB(255, 164, 46, 46)),

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
                hintText: 'الكمية المتاحة',
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
                errorStyle: TextStyle(color: Color.fromARGB(255, 164, 46, 46)),

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
                  return 'أدخل كمية المنتج';
                }
                return null;
              },
            ),

            SizedBox(
              height: 20,
            ),

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
                label: Text('إرفاق صورة'), // <-- Text
              ),
            ),
            if (uploadImageUrl.isEmpty)
              SizedBox()
            else
              Image.network(
                uploadImageUrl,
                width: 150,
                height: 150,
              ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  String prodName = nameController.text;
                  String desc = descController.text;
                  int amount = int.parse(amountController.text);

                  Product product = Product(
                      name: prodName,
                      dsscription: desc,
                      avalibleAmount: amount,
                      image: uploadImageUrl,
                      categoryName: dropdownvalue);

                  await Firestore.saveProduct(product);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('تم حفظ المنتج')),
                  );
                }
              },
              child: Text("إضافة منتج"),
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
                backgroundColor:
                    MaterialStateProperty.all(Color.fromARGB(255, 167, 29, 29)),
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(horizontal: 90, vertical: 13)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27))),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("إلغاء "),
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
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('إرفاق صورة'),
          actions: <Widget>[
            TextButton(
              child: const Text('من الاستدويو'),
              onPressed: () async {
                // Pick an image
                final XFile? photo =
                    await _picker.pickImage(source: ImageSource.gallery);

                final file = File(photo!.path);
                uploadImageToFirebaseStorage(file);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('إلتقاط صورة'),
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
