import 'dart:io';

import 'package:attendance_app/modal/const/text_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../controller/home_screen_controller.dart';
import '../../../modal/const/const_color.dart';
import '../../../modal/const/const_image.dart';
import '../../../modal/const/list.dart';
import '../../../modal/custom/app_bar.dart';
import '../../../modal/modal_class/user.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final HomeScreenController homeController = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
            height: double.infinity,
            width: double.infinity,
            color: ConstColor.primaryBackGround,
            child: Column(
              children: [
                SizedBox(
                  height:
                      MediaQuery.of(context).padding.top + size.height * 0.02,
                ),
                CustomAppBar(
                  onTap: () {
                    homeController.notificationVisible.value =
                        !homeController.notificationVisible.value;
                  },
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "My Profile",
                      style: textStyleW700(
                        size.width * 0.07,
                          ConstColor.blackText,
                          ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.1,
                ),
                Container(
                  width: size.width,
                  height: size.height * 0.2,
                  decoration: BoxDecoration(
                    color: ConstColor.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.09,
                      ),
                      Text(
                        User.name,
                        style: TextStyle(
                            fontSize: size.width * 0.055,
                            color: ConstColor.blackText,
                            fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        User.designation,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            // size.width * 0.042,
                            fontWeight: FontWeight.w600,
                            color: ConstColor.blackText.withOpacity(0.6)),
                      ),
                      Text(
                        "Joined from ${User.joiningDate}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            // size.width * 0.042,
                            fontWeight: FontWeight.w600,
                            color: ConstColor.blackText.withOpacity(0.6)),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Expanded(
                  child: Container(
                    height: size.height,
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                      ),
                      color: ConstColor.white,
                    ),
                    child: ListView.builder(
                        padding: EdgeInsets.only(top: 20),
                        itemCount: profilePageList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: size.width,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        profilePageListData[index],
                                        style: TextStyle(
                                            fontSize: size.width * 0.04,
                                            fontWeight: FontWeight.w600,
                                            color: ConstColor.blackText
                                                .withOpacity(0.6)),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 1,
                                        color: ConstColor.grey.withOpacity(0.9),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: InkWell(
              onTap: () {},
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).padding.top +
                        size.height * 0.175,
                  ),
                  GestureDetector(
                    onTap: () {
                      pickUploadProfilePic();
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      // backgroundColor: Colors.transparent,
                      radius: size.width * 0.18,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipOval(
                          child: (User.profile == " ")
                              ? Image.asset(
                                  ConstImage.rutvik,
                                )
                              : Image.network(
                                  User.profile,
                                ),
                        ),
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

  void pickUploadProfilePic() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 256,
      maxWidth: 256,
      imageQuality: 90,
    );
    String fileName = "${User.name}_profile";

    Reference reference = FirebaseStorage.instance.ref();
    Reference referenceImages = reference.child("profileImages");

    Reference referenceImagesUpload = referenceImages.child(fileName);
    await referenceImagesUpload.putFile(File(image!.path));

    referenceImagesUpload.getDownloadURL().then((value) async {
      setState(() {
        User.profile = value;
      });

      await FirebaseFirestore.instance
          .collection("Employee")
          .doc(User.id)
          .update({'profile': value});
    });
  }
}
