import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:herfaty/profile%20screens/CustomerEditProfile.dart';

import '../pages/login.dart';
import '../pages/signupCustomer.dart';

class CustomerProfile extends StatefulWidget {
  const CustomerProfile({super.key});

  @override
  State<CustomerProfile> createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  var uid;

  String? id = '';
  String? email = '';
  String? name = '';
  String? password = '';

  final CollectionReference customers =
      FirebaseFirestore.instance.collection('customeres');

  get kPrimaryColor => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("حسابي", style: TextStyle(color: kPrimaryColor)),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.logout, color: kPrimaryColor),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => login()));
            },
          ),
          automaticallyImplyLeading: false,
          iconTheme: IconThemeData(color: kPrimaryColor),
        ),
        body: FutureBuilder<Customer?>(
          future: readUser(),
          builder: ((context, snapshot) {
            if (snapshot.hasError) {
              return Text('!هناك خطأ في استرجاع البيانات${snapshot.hasError}');
            } else if (snapshot.hasData) {
              final customer = snapshot.data;
              return customer == null
                  ? const Center(child: Text('!لا توجد معلومات الحرفي'))
                  : buildCustomer(customer);
            } else {
              // ignore: prefer_const_constructors
              return Center(
                child: const CircularProgressIndicator(),
              );
            }
          }),
        ));
  }

  Future<Customer?> readUser() async {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    print(uid);

    final docCustomer =
        FirebaseFirestore.instance.collection('customers').doc(uid);
    final snapshot = await docCustomer.get();
    if (snapshot.exists) {
      return Customer.fromJson(snapshot.data()!);
    }
  }

  Widget buildCustomer(Customer customer) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 400,
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: ListView(
                children: [
                  Container(
                    child: Text("معلومات المشتري",
                        style: TextStyle(color: Colors.black)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: SizedBox(
                      height: 340,
                      child: Column(
                        children: [
                          Expanded(
                              child: Row(
                            children: <Widget>[
                              Text(
                                "الاسم  ",
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromARGB(255, 26, 96, 91)),
                              ),
                              Text(
                                "  ${customer.name}",
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              )
                            ],
                          )),
                          Expanded(
                              child: Row(
                            children: <Widget>[
                              Text(
                                "البريد الالكتروني",
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromARGB(255, 26, 96, 91)),
                              ),
                              Text(
                                "  ${customer.email}",
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              )
                            ],
                          )),
                          Expanded(
                            child: Row(children: [
                              SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color(0xff51908E)),
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.symmetric(
                                          horizontal: 50, vertical: 13)),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(27))),
                                ),
                                child: Text(
                                  " تعديل البيانات",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: "Tajawal",
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                onPressed: () {
// Diolog to enter the password

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CustomerEditProfile()),
                                  );
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color.fromARGB(255, 221, 112, 112)),
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.symmetric(
                                          horizontal: 50, vertical: 13)),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(27))),
                                ),
                                child: Text(
                                  "حذف الحساب",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: "Tajawal",
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ]),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
