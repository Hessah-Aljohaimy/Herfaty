
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:herfaty/firestore/firestore.dart';
import 'package:herfaty/models/product.dart';
import 'package:herfaty/screens/ownerProductsCateg.dart';
import 'package:image_picker/image_picker.dart'; //there
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

import 'package:herfaty/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

class beforeCheckOut extends StatefulWidget {
  const beforeCheckOut({super.key});

  @override
  State<beforeCheckOut> createState() => _beforeCheckOut();
}

class _beforeCheckOut extends State<beforeCheckOut> {
  @override
       final _formKey = GlobalKey<FormState>(); //To validate form


//Text controllers
  var nameController = TextEditingController();
  var descController = TextEditingController();
  var amountController = TextEditingController();
  var priceController = TextEditingController();


  @override
  // Widget build(BuildContext context) {
    String googleApikey = "AIzaSyCo4AQumObYCnbkVAjr2deZ3cjeDilyhY0";
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  LatLng startLocation = LatLng(27.6602292, 85.308027); 
  String location = "Search Location"; 

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          appBar: AppBar( 
             title: Text("Place Picker in Google Map"),
             backgroundColor: Colors.deepPurpleAccent,
          ),
          body: Stack(
            children:[

              GoogleMap( //Map widget from google_maps_flutter package
                  zoomGesturesEnabled: true, //enable Zoom in, out on map
                  initialCameraPosition: CameraPosition( //innital position in map
                    target: startLocation, //initial position
                    zoom: 14.0, //initial zoom level
                  ),
                  mapType: MapType.normal, //map type
                  onMapCreated: (controller) { //method called when map is created
                    setState(() {
                      mapController = controller; 
                    });
                  },
                  onCameraMove: (CameraPosition cameraPositiona) {
                      cameraPosition = cameraPositiona;
                  },
                  onCameraIdle: () async {
                     List<Placemark> placemarks = await placemarkFromCoordinates(cameraPosition!.target.latitude, cameraPosition!.target.longitude);
                     setState(() {
                        location = placemarks.first.administrativeArea.toString() + ", " +  placemarks.first.street.toString();
                     });
                  },
             ),

             Center( //picker image on google map
                child: Image.asset("assets/images/AppIcon.png", width: 80,),
             ),

            //  search autoconplete input
             Positioned(  //search input bar
               top:10,
               child: InkWell(
                 onTap: () async {
                  var place = await PlacesAutocomplete.show(
                          context: context,
                          apiKey: googleApikey,
                          mode: Mode.overlay,
                          types: [],
                          strictbounds: false,
                          components: [Component(Component.country, 'np')],
                                      //google_map_webservice package
                          onError: (err){
                             print(err);
                          }
                      );

                   if(place != null){
                        setState(() {
                          location = place.description.toString();
                        });
                       //form google_maps_webservice package
                       final plist = GoogleMapsPlaces(apiKey:googleApikey,
                              apiHeaders: await GoogleApiHeaders().getHeaders(),
                                        //from google_api_headers package
                        );
                        String placeid = place.placeId ?? "0";
                        final detail = await plist.getDetailsByPlaceId(placeid);
                        final geometry = detail.result.geometry!;
                        final lat = geometry.location.lat;
                        final lang = geometry.location.lng;
                        var newlatlang = LatLng(lat, lang);

                        //move map camera to selected place with animation
                        mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: newlatlang, zoom: 17)));
                   }
                 },
                 child:Padding(
                   padding: EdgeInsets.all(15),
                    child: Card(
                       child: Container(
                         padding: EdgeInsets.all(0),
                         width: MediaQuery.of(context).size.width - 40,
                         child: ListTile(
                            leading: Image.asset("assets/images/AppIcon.png", width: 25,),
                            title:Text(location, style: TextStyle(fontSize: 18),),
                            trailing: Icon(Icons.search),
                            dense: true,
                         )
                       ),
                    ),
                 )
               )
             )


            ]
          )
       );
  }

}
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(56.0),
//         child: Container(
//           child: const DefaultAppBar(title: " بيانات التوصيل والدفع"),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             //can doing scroll

//             children: <Widget>[
//               SizedBox(
//                 height: 10,
//               ),
           

            
           
//               SizedBox(
//                 height: 20,
//               ),
//               Row(
//                 //
//                 mainAxisAlignment:
//                     MainAxisAlignment.spaceEvenly, //for right edge
//                 children: [
//                   SizedBox(width: 20), // for space
//                 ]
//               ),
           

//               SizedBox(
//                 height: 30,
//               ),

              
//               Text('مجموع طلبك:30 ريال',style: TextStyle( color: kPrimaryColor, fontFamily: "Tajawal",fontSize: 20)),
//                SizedBox(
//                 height: 10,
//               ),
//                Text('عددد المنتجات:7',style: TextStyle( color: kPrimaryColor, fontFamily: "Tajawal",fontSize: 20)),
//                 SizedBox(
//                 height: 20,
//               ),
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 40),
//                 child: TextFormField(
//                   controller: nameController,
//                   //right aligment

//                   decoration: InputDecoration(
//                     border: InputBorder.none,
//                     hintText: 'المدينة',
//                     hintStyle: TextStyle(fontSize: 18, fontFamily: "Tajawal"),
//                     suffixIcon: Padding(
//                       padding: EdgeInsets.only(top: 15),
//                       child: Icon(Icons.production_quantity_limits_sharp,
//                           color: kPrimaryColor),
//                     ),
//                     contentPadding: const EdgeInsets.symmetric(
//                         vertical: 3.0, horizontal: 23),
//                     labelStyle:
//                         TextStyle(color: kPrimaryColor, fontFamily: "Tajawal"),
//                     // floatingLabelBehavior: FloatingLabelBehavior.never,
//                     fillColor: Colors.white.withOpacity(0.3),

//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: kPrimaryColor),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(width: 2, color: kPrimaryColor),
//                     ),
//                     errorStyle:
//                         TextStyle(color: Color.fromARGB(255, 164, 46, 46)),

//                     errorBorder: OutlineInputBorder(
//                       borderSide:
//                           BorderSide(color: Color.fromARGB(255, 164, 46, 46)),
//                     ),

//                     focusedErrorBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                           width: 2, color: Color.fromARGB(255, 164, 46, 46)),
//                     ),
//                   ),

//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'أدخل اسم المنتج';
//                     }
//                     if (!RegExp(
//                             r"^[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z ]+[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z- ][]*$")
//                         .hasMatch(value)) {
//                       return "أدخل اسم بلا أرقام ورموز";
//                     }
//                     if (value.length < 2) {
//                       return " أدخل اسم أكبر من أو يساوي حرفين ";
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//               /*Container(
//                 child: Text(
//                   "اسم صحيح بلا أرقام ورموز",
//                   textAlign: TextAlign.right,
//                   style: TextStyle(color: Color.fromARGB(255, 235, 47, 26)),
//                 ),
//               ),*/

//               SizedBox(
//                 height: 20,
//               ), //for space
            
//               SizedBox(
//                 height: 20,
//               ),
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 40),
//                 child: TextFormField(
//                   controller: amountController,
//                   keyboardType: TextInputType.number,
//                   textAlign: TextAlign.right,
//                   decoration: InputDecoration(
//                     border: InputBorder.none,
//                     hintText: 'الكمية المتاحة',
//                     contentPadding: const EdgeInsets.symmetric(
//                         vertical: 3.0, horizontal: 23),

//                     hintStyle: TextStyle(fontSize: 18, fontFamily: "Tajawal"),
//                     suffixIcon: Padding(
//                       padding: EdgeInsets.only(top: 15),
//                       child: Icon(Icons.numbers,
//                           //Sara edits
//                           color: kPrimaryColor),
//                     ),
//                     labelStyle:
//                         TextStyle(color: kPrimaryColor, fontFamily: "Tajawal"),
//                     // floatingLabelBehavior: FloatingLabelBehavior.never,
//                     fillColor: Colors.white.withOpacity(0.3),

//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: kPrimaryColor),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(width: 2, color: kPrimaryColor),
//                     ),
//                     errorStyle:
//                         TextStyle(color: Color.fromARGB(255, 164, 46, 46)),

//                     errorBorder: OutlineInputBorder(
//                       borderSide:
//                           BorderSide(color: Color.fromARGB(255, 164, 46, 46)),
//                     ),

//                     focusedErrorBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                           width: 2, color: Color.fromARGB(255, 164, 46, 46)),
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty)
//                       return 'أدخل كمية المنتج';
//                     if (int.parse(value) <= 0) return "أدخل رقم أكبر من صفر";
//                     if (int.parse(value) > 15)
//                       return "أدخل رقم أصغر من أو يساوي 15";
//                     else
//                       return null;
//                   },
//                 ),
//               ),
             
//               SizedBox(
//                 height: 20,
//               ),
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 40),
//                 child: TextFormField(
//                   controller: priceController,
//                   keyboardType: TextInputType.number,
//                   textAlign: TextAlign.right,
//                   decoration: InputDecoration(
//                     hintText: 'السعر',
//                     contentPadding: const EdgeInsets.symmetric(
//                         vertical: 3.0, horizontal: 23),

//                     hintStyle: TextStyle(fontSize: 18, fontFamily: "Tajawal"),
//                     suffixIcon: Padding(
//                       padding: EdgeInsets.only(top: 15),
//                       child: Icon(Icons.attach_money_outlined,
//                           //Sara edits
//                           color: kPrimaryColor),
//                     ),
//                     labelStyle:
//                         TextStyle(color: kPrimaryColor, fontFamily: "Tajawal"),
//                     // floatingLabelBehavior: FloatingLabelBehavior.never,
//                     fillColor: Colors.white.withOpacity(0.3),

//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: kPrimaryColor),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(width: 2, color: kPrimaryColor),
//                     ),
//                     errorStyle:
//                         TextStyle(color: Color.fromARGB(255, 164, 46, 46)),

//                     errorBorder: OutlineInputBorder(
//                       borderSide:
//                           BorderSide(color: Color.fromARGB(255, 164, 46, 46)),
//                     ),

//                     focusedErrorBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                           width: 2, color: Color.fromARGB(255, 164, 46, 46)),
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty)
//                       return 'أدخل السعر ';
//                     else if (int.parse(value!) <= 0)
//                       return "أدخل رقم أكبر من صفر";
//                     else
//                       return null;
//                   },
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),

//               SizedBox(
//                 height: 180,
//               ),
               
//               ElevatedButton(
//                 onPressed: () async {
                
//                   /*if (uploadImageUrl.isEmpty &&
//                       _formKey.currentState.validate()) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text('الرجاء إرفاق صورة')));
//                     _showMyDialog();
//                   }*/

//                   if (_formKey.currentState!.validate() 
//                     ) {
//                     String prodName = nameController.text;
//                     String desc = descController.text;
//                     int amount = int.parse(amountController.text);
//                     double priceN = double.parse(priceController.text);

//                     final productToBeAdded =
//                         FirebaseFirestore.instance.collection('Products').doc();
//                     Product product = Product(
//                         id: productToBeAdded.id,
//                         name: prodName,
//                         dsscription: desc,
//                         avalibleAmount: amount,
//                         image: "uploadImageUrl",
//                         categoryName: "dropdownvalue",
//                         price: priceN);
//                     final json = product.toJson();
//                     await productToBeAdded.set(json);
//                     //await Firestore.saveProduct(product);
//                     Fluttertoast.showToast(
//                       msg: "تمت إضافة المنتج بنجاح",
//                       toastLength: Toast.LENGTH_SHORT,
//                       gravity: ToastGravity.CENTER,
//                       timeInSecForIosWeb: 3,
//                       backgroundColor: Color.fromARGB(255, 26, 96, 91),
//                       textColor: Colors.white,
//                       fontSize: 18.0,
//                     );
//                     await Future.delayed(const Duration(seconds: 1), () {
//                       Navigator.pop(context);
//                     });

//                     // ScaffoldMessenger.of(context).showSnackBar(
//                     //   const SnackBar(content: Text('تم حفظ المنتج')),
//                     // );
//                   }
//                   /*   nameController.clear();
//                   descController.clear();
//                   amountController.clear();
//                   priceController.clear();*/
//                 },
                
//                 style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all(Color(0xff51908E)),
//                   padding: MaterialStateProperty.all(
//                       EdgeInsets.symmetric(horizontal: 40, vertical: 13)),
//                   shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(27))),
//                 ),
//                 child: Text(
//                   "المتابعة للدفع",
//                   style: TextStyle(
//                       fontSize: 14,
//                       fontFamily: "Tajawal",
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//               /* child: Text("إضافة منتج"),
//                 style: ElevatedButton.styleFrom(
//                     primary: Color.fromARGB(255, 26, 96, 91)),
//               ),*/

//               SizedBox(
//                 height: 20,
//               ),

//               ElevatedButton(
//                 style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all(
//                       Color.fromARGB(255, 167, 29, 29)),
//                   padding: MaterialStateProperty.all(
//                       EdgeInsets.symmetric(horizontal: 40, vertical: 13)),
//                   shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(27))),
//                 ),
//                 child: Text(
//                   "إلغاء",
//                   style: TextStyle(
//                       fontSize: 14,
//                       fontFamily: "Tajawal",
//                       fontWeight: FontWeight.bold),
//                 ),
//                 onPressed: () {
//                   showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return AlertDialog(
//                           title: Text("تنبيه"),
//                           content: Text('سيتم إلغاء إضافة هذا المنتج'),
//                           actions: <Widget>[
//                             TextButton(
//                               child: Text(" تأكيد",
//                                   style: TextStyle(color: Colors.red)),
//                               onPressed: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           const ownerProductsCategScreen()),
//                                 );
//                               },
//                             ),
//                             TextButton(
//                               child: Text("تراجع"),
//                               onPressed: () {
//                                 Navigator.of(context).pop();
//                               },
//                             )
//                           ],
//                         );
//                       });
//                 },
//               ),
//               /* ElevatedButton(
//                 style: ElevatedButton.styleFrom(primary: Colors.red),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text("إلغاء "),
//               ),*/
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   }





// class DefaultAppBar extends StatelessWidget {
//   final String title;
//   const DefaultAppBar({
//     Key? key,
//     required this.title,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       title: Text(title, style: TextStyle(color: kPrimaryColor)),
//       leading: IconButton(
//         padding: EdgeInsets.only(right: 20),
//         icon: const Icon(
//           Icons.arrow_back, //سهم العودة
//           color: kPrimaryColor,
//           size: 22.0,
//         ),
//         onPressed: () {
//           Navigator.pop(context);
//         },
//       ),
//       centerTitle: true,
//       backgroundColor: Colors.white,
//       elevation: 0,
//       automaticallyImplyLeading: false,
//       iconTheme: IconThemeData(color: kPrimaryColor),
//     );





//   }
// }