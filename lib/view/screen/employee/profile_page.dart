import 'dart:io';

import 'package:attendance_app/modal/const/text_style.dart';
import 'package:attendance_app/modal/custom/profile_screen_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../controller/home_screen_controller.dart';
import '../../../modal/const/const_color.dart';
import '../../../modal/const/const_image.dart';
import '../../../modal/custom/app_bar.dart';
import '../../../modal/modal_class/user.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final HomeScreenController homeController = Get.put(HomeScreenController());
  TextEditingController employeeID = TextEditingController();
  TextEditingController emailID = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController birthDate = TextEditingController();
  TextEditingController bloodGroup = TextEditingController();
  TextEditingController aadhaarNo = TextEditingController();
  TextEditingController panNo = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController emergencyNo = TextEditingController();

  @override
  void initState() {
    employeeID.text = User.employeeId;
    emailID.text = User.mail;
    mobileNo.text = User.mobile;
    birthDate.text = User.birthdate;
    bloodGroup.text = User.bloodGroup;
    aadhaarNo.text = User.aadhaarNo;
    panNo.text = User.panNo;
    address.text = User.address;
    emergencyNo.text = User.emergency;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
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
              height: size.height * 0.04,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 25),
                width: size.width,
                height: size.height,
                decoration: BoxDecoration(
                  color: ConstColor.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: size.height * 0.02,),
                      GestureDetector(
                        onTap: () {
                          pickUploadProfilePic();
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          // backgroundColor: Colors.transparent,
                          radius: size.width * 0.18,
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: ConstColor.primary,width: 1.5)),
                            child: ClipOval(
                              child: (User.profile == " ")
                                  ? Image.asset(
                                ConstImage.rutvik,
                              )
                                  : Image.network(User.profile),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02,),
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
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      ProfileScreenField(
                        label: 'Employee ID:',
                        controller: employeeID,
                        isEditIcon: false,
                      ),
                      ProfileScreenField(
                        label: 'Email ID:',
                        controller: emailID,
                        isEditIcon: true,
                        pencilOnTap: () {},
                      ),
                      ProfileScreenField(
                        label: 'Mobile No:',
                        controller: mobileNo,
                        isEditIcon: true,
                        pencilOnTap: () {},
                      ),
                      ProfileScreenField(
                        label: 'Birth Date:',
                        controller: birthDate,
                        isEditIcon: false,
                      ),
                      ProfileScreenField(
                        label: 'Blood Group:',
                        controller: bloodGroup,
                        isEditIcon: true,
                        pencilOnTap: () {},
                      ),
                      ProfileScreenField(
                        label: 'Aadhaar No:',
                        controller: aadhaarNo,
                        isEditIcon: false,
                      ),
                      ProfileScreenField(
                        label: 'PAN No:',
                        controller: panNo,
                        isEditIcon: false,
                      ),
                      ProfileScreenField(
                        label: 'Address:',
                        controller: address,
                        isEditIcon: true,
                        pencilOnTap: () {},
                      ),
                      ProfileScreenField(
                        label: 'Emergency No:',
                        controller: emergencyNo,
                        isEditIcon: false,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
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

      await FirebaseFirestore.instance.collection("Employee").doc(User.id).update({'profile': value});
    });
  }
}
