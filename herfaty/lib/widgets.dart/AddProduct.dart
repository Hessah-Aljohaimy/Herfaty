import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:herfaty/firestore/firestore.dart';
import 'package:herfaty/models.dart/product.dart';

class AddProduct extends StatefulWidget {
  AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();

  // Initial Selected Value
  String dropdownvalue = 'الرسم والتلوين';
  // List of items in our dropdown menu
  var items = [
    'الرسم والتلوين',
    'الخرز والإكسسوار',
    'الفخاريات',
    'الحياكة والتطريز',
  ];

  var nameController = TextEditingController();
  var descController = TextEditingController();
  var amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
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
                SizedBox(width: 20),
                Text('فئة المنتج'),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: nameController,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: 'اسم المنتج',
                prefixIcon: Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Icon(Icons.person),
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
            ),
            TextFormField(
              controller: descController,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: 'تفاصيل المنتج',
                prefixIcon: Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Icon(Icons.description),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
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
                  child: Icon(Icons.numbers),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
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
                onPressed: () {},
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
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () async {
                String name = nameController.text;
                String desc = descController.text;
                int amount = int.parse(amountController.text);

                Product product = Product(
                    name: name,
                    dsscription: desc,
                    avalibleAmount: amount,
                    image: "",
                    categoryName: dropdownvalue);

                if (_formKey.currentState!.validate()) {
                  await Firestore.saveProduct(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Data sent to firestore')),
                  );
                }
              },
              child: Text("أضافة منتج"),
              style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 26, 96, 91)),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.red),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("الغاء "),
            ),
          ],
        ),
      ),
    );
  }
}
