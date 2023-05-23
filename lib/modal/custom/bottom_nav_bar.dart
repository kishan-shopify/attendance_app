import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../controller/home_screen_controller.dart';
import '../const/const_color.dart';
import '../const/list.dart';

class BottomNavBar extends StatelessWidget {
  final Size size;
  final Function onTap;

  BottomNavBar({
    Key? key,
    required this.size,
    required this.onTap,
  }) : super(key: key);

  final HomeScreenController controller = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 70,
      decoration:  BoxDecoration(
        color: ConstColor.white,
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: ListView.builder(

        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: bottomNavBarItems.length,
        itemBuilder: (context, index) {
          return Obx(
            () => GestureDetector(
              onTap: () {
                onTap(index);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: Image.asset(
                  bottomNavBarItems[index],
                  fit: BoxFit.contain,
                  height: 30,
                  width: 30,
                  color: (controller.tappedIndex.value == index) ? ConstColor.btnGradient1 : Colors.grey.withOpacity(1),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
