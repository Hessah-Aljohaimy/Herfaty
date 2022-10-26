// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';

class ratingDialog extends StatefulWidget {
  const ratingDialog({super.key});

  @override
  State<ratingDialog> createState() => _ratingDialogState();
}

class _ratingDialogState extends State<ratingDialog> {
  @override
  // show the rating dialog
  void _showRatingDialog() {
    final _dialog = RatingDialog(
      initialRating: 0.0,
      // your app's name?
      title: Text(
        'تقييم الطلب',
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w900,
          color: Colors.amber,
        ),
      ),
      // encourage your user to leave a high rating?
      message: Text(
        "عزيزي المشتري: فضلًا قيّم المتجر باختيار عدد النجوم المناسب، وأضف تعليقًا إذا أردت.",
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w800,
          color: Color.fromARGB(157, 20, 129, 137),
        ),
      ),
      // your app's logo?
      image: Icon(
        Icons.check_outlined,
        color: Color.fromARGB(157, 20, 129, 137),
        size: 80.0,
      ),
      submitButtonText: 'إرسال',
      commentHint: 'اكتب تعليقك هنا',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        print('rating: ${response.rating}, comment: ${response.comment}');

        // TODO: add your own logic
        if (response.rating < 3.0) {
          // send their comments to your email or anywhere you wish
          // ask the user to contact you instead of leaving a bad review
        } else {
          //_rateAndReviewApp();
        }
      },
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: true, // set to false if you want to force a rating
      builder: (context) => _dialog,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Color.fromARGB(157, 20, 129, 137),
        //   title: const Text('صفحة تقييم الطلب'),
        //   centerTitle: true,
        // ),

        // body: Container(
        //   child: Center(
        //     //=====================================================Elevated button
        //     child: ElevatedButton(
        //       style: ElevatedButton.styleFrom(
        //         backgroundColor: Color.fromARGB(157, 20, 129, 137),
        //         padding: const EdgeInsets.only(
        //           right: 26,
        //           left: 26,
        //           top: 10,
        //           bottom: 10,
        //         ),
        //         shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(10.0)),
        //       ),
        //       child: Text(
        //         'قيِّـم الطلب',
        //         style: TextStyle(
        //           fontSize: 19,
        //           fontWeight: FontWeight.w800,
        //           color: Colors.white,
        //         ),
        //       ),
        //       onPressed: _showRatingDialog,
        //     ),
        //   ),
        // ),
        );
  }
}
