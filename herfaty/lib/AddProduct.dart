import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:herfaty/firestore/firestore.dart';
import 'package:herfaty/models/product.dart';
import 'package:herfaty/screens/ownerProductsCateg.dart';
import 'package:image_picker/image_picker.dart'; //there
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
//import'package:assets/images/productPic.png';
import 'constants/color.dart';
import 'models/shopOwnerModel.dart';
import 'package:intl/intl.dart';

class AddProduct extends StatefulWidget {
  AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>(); //To validate form

  // Initial Selected Value
  String dropdownvalue = '  اختر الفئة:'; // default value
  // List of items in our dropdown menu
  var items = [
    '  اختر الفئة:',
    'فنون الورق والتلوين',
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
  bool showLocalImage = false;
  File? pickedImage1;

  @override
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
          child: const DefaultAppBar(title: " إضافة منتج"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/cartBack1.png'),
                  fit: BoxFit.cover)),
          child: Form(
            key: _formKey,
            child: ListView(
              //can doing scroll

              children: <Widget>[
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

                if (uploadImageUrl.isEmpty)
                  imageProfile()
                else
                  Container(
                    height: 200,
                    width: 200,
                    //color: Color(0xffFF0E58),
                    child: Image.network(
                      uploadImageUrl,
                      //fit: BoxFit.cover,
                    ),
                  ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center, //for right edge
                  children: [
                    //SizedBox(width: 20), // for space

                    ElevatedButton.icon(
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
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  //
                  mainAxisAlignment: MainAxisAlignment.start, //for right edge
                  children: [
                    SizedBox(width: 20), // for space
                    Text(
                      '    فئة المنتج:    ',
                      style: TextStyle(
                          fontSize: 21,
                          fontFamily: "Tajawal",
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold),
                    ),

                    Container(
                      padding: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: Colors.white, //<-- SEE HERE
                      ),
                      child: DropdownButton(
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
                    ),
                  ],
                ),

                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: nameController,
                    maxLength: 30,
                    //right aligment

                    decoration: InputDecoration(
                      border: InputBorder.none,

                      hintText: 'اسم المنتج',
                      labelText: 'اسم المنتج',

                      hintStyle: TextStyle(fontSize: 18, fontFamily: "Tajawal"),
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(top: 15),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 3.0, horizontal: 23),
                      labelStyle: TextStyle(
                          color: kPrimaryColor, fontFamily: "Tajawal"),
                      // floatingLabelBehavior: FloatingLabelBehavior.never,
                      filled: true,

                      fillColor: Colors.white,

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
                      if (value!.trim() == null || value.trim().isEmpty) {
                        return 'أدخل اسم المنتج';
                      }
                      if (value.trim().length < 2) {
                        return " أدخل اسم أكبر من أو يساوي حرفين ";
                      }
                      if (!RegExp(
                              r"^[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z ]+[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z- ][]*$")
                          .hasMatch(value)) {
                        return "أدخل اسم بلا أرقام ورموز";
                      }

                      return null;
                    },
                  ),
                ),

                SizedBox(
                  height: 20,
                ), //for space
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: descController,
                    textAlign: TextAlign.right,
                    maxLength: 300,
                    decoration: InputDecoration(
                      hintText: 'تفاصيل المنتج',
                      labelText: 'تفاصيل المنتج',
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 3.0, horizontal: 23),
                      hintStyle: TextStyle(fontSize: 18, fontFamily: "Tajawal"),
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(top: 15),
                      ),
                      labelStyle: TextStyle(
                          color: kPrimaryColor, fontFamily: "Tajawal"),
                      filled: true,
                      fillColor: Colors.white,
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
                      if (value!.trim() == null || value.trim().isEmpty) {
                        return 'أدخل وصف المنتج';
                      }
                      if (value.trim().length < 2) {
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'الكمية المتاحة',
                      labelText: 'الكمية المتاحة',

                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 3.0, horizontal: 23),

                      hintStyle: TextStyle(fontSize: 18, fontFamily: "Tajawal"),
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(top: 15),
                        // child: Icon(Icons.numbers,
                        //     //Sara edits
                        //     color: kPrimaryColor),
                      ),
                      labelStyle: TextStyle(
                          color: kPrimaryColor, fontFamily: "Tajawal"),
                      // floatingLabelBehavior: FloatingLabelBehavior.never,
                      filled: true,
                      fillColor: Colors.white,

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

                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      hintText: 'السعر',
                      labelText: 'السعر',
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 3.0, horizontal: 23),
                      hintStyle: TextStyle(fontSize: 18, fontFamily: "Tajawal"),
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(top: 15),
                      ),
                      labelStyle: TextStyle(
                          color: kPrimaryColor, fontFamily: "Tajawal"),
                      filled: true,
                      fillColor: Colors.white,
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
                      else if (double.parse(value!) <= 0)
                        return "أدخل سعر أكبر من صفر";
                      else if (double.parse(value!) > 500)
                        return " أدخل سعر أقل من أو يساوي 500 ";
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
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            if (uploadImageUrl.isEmpty)
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('الرجاء إرفاق صورة')));
                            if (dropdownvalue == '  اختر الفئة:')
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('الرجاء إختيار الفئة ')));

                            if (_formKey.currentState!.validate() &&
                                uploadImageUrl != "" &&
                                dropdownvalue != '  اختر الفئة:') {
                              String prodName = nameController.text;
                              String desc = descController.text;
                              int amount = int.parse(amountController.text);
                              double priceN =
                                  double.parse(priceController.text);

                              DateTime now = DateTime.now();
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

                              final productToBeAdded = FirebaseFirestore
                                  .instance
                                  .collection('Products')
                                  .doc();
                              Product product = Product(
                                  id: productToBeAdded.id,
                                  name: prodName,
                                  dsscription: desc,
                                  avalibleAmount: amount,
                                  image: uploadImageUrl,
                                  categoryName: dropdownvalue,
                                  price: priceN,
                                  shopOwnerId: thisOwnerId,
                                  shopName: shopNameData,
                                  proudctDate: formattedDate);

                              final json = product.toJson();
                              await productToBeAdded.set(json);

                              //---------------------------- duplicate collection

                              final productToBeAdded1 = FirebaseFirestore
                                  .instance
                                  .collection('OrdersProducts')
                                  .doc(productToBeAdded.id);
                              Product product1 = Product(
                                  id: productToBeAdded.id,
                                  name: prodName,
                                  dsscription: desc,
                                  avalibleAmount: amount,
                                  image: uploadImageUrl,
                                  categoryName: dropdownvalue,
                                  price: priceN,
                                  shopOwnerId: thisOwnerId,
                                  shopName: shopNameData);

                              final json1 = product1.toJson();
                              await productToBeAdded1.set(json1);

                              //------------------------------------
                              //await Firestore.saveProduct(product);
                              Fluttertoast.showToast(
                                msg: "تمت إضافة المنتج بنجاح",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 3,
                                backgroundColor:
                                    Color.fromARGB(255, 26, 96, 91),
                                textColor: Colors.white,
                                fontSize: 18.0,
                              );
                              await Future.delayed(const Duration(seconds: 1),
                                  () {
                                Navigator.pop(context);
                              });
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xff51908E)),
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 13)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(27))),
                          ),
                          child: Text(
                            "إضافة المنتج",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Tajawal",
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 221, 112, 112)),
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    horizontal: 60, vertical: 13)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
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
                                builder: (BuildContext context1) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    title: Center(
                                        child: Text(
                                      "تنبيه",
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w700,
                                        color:
                                            Color.fromARGB(255, 221, 112, 112),
                                        fontFamily: "Tajawal",
                                      ),
                                    )),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Center(
                                          child: Container(
                                            width: 250,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                              fit: BoxFit.scaleDown,
                                              image: AssetImage(
                                                  'assets/images/erase.png'),
                                            )),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Center(
                                            child: Text(
                                          'سيتم إلغاء إضافة هذا المنتج',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color:
                                                Color.fromARGB(255, 26, 96, 91),
                                            fontFamily: "Tajawal",
                                          ),
                                        )),
                                      ],
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text("تراجع"),
                                        onPressed: () {
                                          Navigator.of(context1).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: Text(" إلغاء",
                                            style:
                                                TextStyle(color: Colors.red)),
                                        onPressed: () {
                                          Navigator.of(context1).pop();
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
                        ),
                      ]),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      ),
      // ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(children: <Widget>[
        Container(
          height: 200,
          width: 200,
          child: Image.asset('assets/images/points_trophies/squareImagee.jpg'),
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
            onTap: () {
              _showMyDialog();
            },
          ),
        ),
      ]),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "اختر صورة",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () async {
                // Capture a photo
                takePhoto(ImageSource.camera);

                Navigator.of(context).pop();
              },
              label: Text("الكاميرا"),
            ),
            TextButton.icon(
              icon: Icon(Icons.image),
              onPressed: () async {
                takePhoto(ImageSource.gallery);

                Navigator.of(context).pop();
              },
              label: Text("الصور"),
            ),
          ])
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    XFile? file1 = await ImagePicker().pickImage(source: source);
    if (file1 == null) return;

    setState(() {
      try {
        pickedImage1 = File(file1.path);
        showLocalImage = true;

        uploadImageToFirebaseStorage(pickedImage1!);
        uploadImageUrl = pickedImage1!.uri.toString();
        print(uploadImageUrl);
        Fluttertoast.showToast(
          msg: 'تمت إضافة الصورة بنجاح',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Color.fromARGB(255, 26, 96, 91),
          textColor: Colors.white,
          fontSize: 18.0,
        );
      } catch (e) {
        Fluttertoast.showToast(
          msg: 'هناك مشكلة أعد ادخال الصوره مجددا',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.white,
          textColor: Colors.red,
          fontSize: 18.0,
        );
      }
    });
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

class DefaultAppBar extends StatelessWidget {
  final String title;
  const DefaultAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: TextStyle(color: kPrimaryColor)),
      leading: IconButton(
        padding: EdgeInsets.only(right: 20),
        icon: const Icon(
          Icons.arrow_back, //سهم العودة
          color: kPrimaryColor,
          size: 22.0,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 3,
      automaticallyImplyLeading: false,
      iconTheme: IconThemeData(color: kPrimaryColor),
    );
  }
}
