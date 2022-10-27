import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:herfaty/points%20base/Reward.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class RewardsCarousel extends StatefulWidget {
  const RewardsCarousel({super.key});

  @override
  State<RewardsCarousel> createState() => _RewardsCarouselState();
}

class _RewardsCarouselState extends State<RewardsCarousel> {
  int _current = 0;
  List<Reward> rewardList = [
    Reward('assets/images/trophy500', 'كأس الإحتراف'),
    Reward('assets/images/trophy200.png', 'كأس الإبداع'),
    Reward('assets/images/trophy100.png', 'كأس المهارة'),
    Reward('assets/images/trophy50ptclosed.png', 'كأس الإتقان'),
    Reward('assets/images/trophy10.png', 'كأس البدء'),
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 220,
        child: Column(
          children: [
            Container(
              height: 50,
              child: Text(
                "الكؤوس",
                style: TextStyle(
                  color: Color(0xffF19B1A),
                  fontSize: 20,
                ),
              ),
            ),
            ScrollSnapList(
              itemBuilder: _buildListItem,
              itemCount: rewardList.length,
              itemSize: 150,
              onItemFocus: (index) {},
              dynamicItemSize: true,
              scrollDirection: Axis.horizontal,
            ),
          ],
        ));
  }

  Widget _buildListItem(BuildContext context, int index) {
    Reward reward = rewardList[index];
    return SizedBox(
      width: 170,
      height: 200,
      child: GestureDetector(
        child: Container(
          // Within the SecondRoute widget
          padding: const EdgeInsets.all(10),

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.1),
                blurRadius: 4.0,
                spreadRadius: .05,
              ), //BoxShadow
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  reward.imagePath,
                  height: 130.0,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(reward.title,
                  style: TextStyle(
                      color: Color(0xff51908E),
                      fontWeight: FontWeight.bold,
                      fontFamily: "Tajawal",
                      fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }
}
