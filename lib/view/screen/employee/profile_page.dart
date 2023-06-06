import 'package:attendance_app/modal/custom/back_button.dart';
import 'package:flutter/material.dart';

import '../../../modal/const/const_color.dart';
import '../../../modal/const/const_image.dart';
import '../../../modal/const/list.dart';
import '../../../modal/const/text_style.dart';
import '../../../modal/modal_class/user.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      body: Stack(
        children: [
          RotatedBox(
            quarterTurns: 2,
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Image.asset(
                ConstImage.background,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top + 15,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      height: size.height * 0.06,
                      width: size.width * 0.6,
                      child: Image.asset(
                        "assets/images/janovis_logo.png",
                        fit: BoxFit.contain,
                      ),
                    ),

                    GestureDetector(
                      onTap: () {},
                      child: Image.asset(
                        ConstImage.edit,
                        height: 27,
                        width: 27,
                        color: ConstColor.blackText,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.04,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: size.height * 0.15,
                    width: size.width * 0.35,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.7),
                          blurRadius: 4,
                          offset: const Offset(2, 4), // Shadow position
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: size.width * 0.35,
                      child: ClipOval(
                        child: Image.asset(
                          "assets/images/rutvik.jpg",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Text(
                    User.name,
                    style:
                    textStyleW600(size.width * 0.06, ConstColor.blackText),
                  ),
                  Text(
                    User.designation,
                    style: textStyleW500(size.width * 0.038,
                        ConstColor.blackText.withOpacity(0.8)),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: size.height * 0.025,
              ),
              Expanded(
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  height: size.height,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                    color: ConstColor.white.withOpacity(0.85),
                  ),
                  child: ListView.builder(
                      itemCount: profilePageList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            SizedBox(
                              width: size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    profilePageList[index],
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: size.width * 0.041,
                                      color: ConstColor.blackText
                                          .withOpacity(0.9),
                                      overflow: TextOverflow.visible,
                                    ),
                                  ),
                                  const SizedBox(height: 7,),
                                  Text(
                                    profilePageListData[index],
                                    style: textStyleW500(
                                      size.width * 0.04,
                                      ConstColor.grey.withOpacity(0.9),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 1,
                                    color: ConstColor.grey
                                        .withOpacity(0.9),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                          ],
                        );
                      }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
