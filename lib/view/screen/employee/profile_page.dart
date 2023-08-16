import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../controller/edit_profile_controller.dart';
import '../../../controller/home_screen_controller.dart';
import '../../../modal/const/const_color.dart';
import '../../../modal/const/const_image.dart';
import '../../../modal/const/text_style.dart';
import '../../../modal/custom/app_bar.dart';
import '../../../modal/custom/profile_screen_field.dart';
import '../../../modal/modal_class/user.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final HomeScreenController homeController = Get.put(HomeScreenController());
  final EditProfileController editController = Get.put(EditProfileController());

  @override
  void initState() {
    editController.employeeID.value.text = User.employeeId;
    editController.emailID.value.text = User.mail;
    editController.mobileNo.value.text = User.mobile;
    editController.birthDate.value.text = User.birthdate;
    editController.bloodGroup.value.text = User.bloodGroup;
    editController.aadhaarNo.value.text = User.aadhaarNo;
    editController.panNo.value.text = User.panNo;
    editController.address.value.text = User.address;
    editController.emergencyNo.value.text = User.emergency;
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
              height: MediaQuery.of(context).padding.top + size.height * 0.02,
            ),
            CustomAppBar(
              onTap: () {
                homeController.notificationVisible.value = !homeController.notificationVisible.value;
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
                      SizedBox(
                        height: size.height * 0.02,
                      ),
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
                                border: Border.all(
                                    color: ConstColor.primary, width: 1.5)),
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
                      SizedBox(
                        height: size.height * 0.02,
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
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      ProfileScreenField(
                        label: 'Employee ID:',
                        controller: editController.employeeID.value,
                        isEditIcon: false,
                      ),
                      ProfileScreenField(
                        label: 'Email ID:',
                        controller: editController.emailID.value,
                        isEditIcon: true,
                        onSave: () async {
                          QuerySnapshot snap = await FirebaseFirestore.instance
                              .collection("Employee")
                              .where('id', isEqualTo: User.employeeId)
                              .get();

                          await FirebaseFirestore.instance
                              .collection("Employee")
                              .doc(snap.docs[0].id)
                              .update({'mail': editController.emailID.value.text});
                        },
                      ),
                      ProfileScreenField(
                        label: 'Mobile No:',
                        controller: editController.mobileNo.value,
                        isEditIcon: true,
                        onSave: () async {
                          QuerySnapshot snap = await FirebaseFirestore.instance
                              .collection("Employee")
                              .where('id', isEqualTo: User.employeeId)
                              .get();

                          await FirebaseFirestore.instance
                              .collection("Employee")
                              .doc(snap.docs[0].id)
                              .update({
                            'mobile': editController.mobileNo.value.text
                          });
                        },
                      ),
                      ProfileScreenField(
                        label: 'Birth Date:',
                        controller: editController.birthDate.value,
                        isEditIcon: false,
                      ),
                      ProfileScreenField(
                        label: 'Blood Group:',
                        controller: editController.bloodGroup.value,
                        isEditIcon: true,
                        onSave: () async {
                          QuerySnapshot snap = await FirebaseFirestore.instance
                              .collection("Employee")
                              .where('id', isEqualTo: User.employeeId)
                              .get();

                          await FirebaseFirestore.instance
                              .collection("Employee")
                              .doc(snap.docs[0].id)
                              .update({'bloodgroup': editController.bloodGroup.value.text
                          });
                        },
                      ),
                      ProfileScreenField(
                        label: 'Aadhaar No:',
                        controller: editController.aadhaarNo.value,
                        isEditIcon: false,
                      ),
                      ProfileScreenField(
                        label: 'PAN No:',
                        controller: editController.panNo.value,
                        isEditIcon: false,
                      ),
                      ProfileScreenField(
                        label: 'Address:',
                        controller: editController.address.value,
                        isEditIcon: true,
                        onSave: () async {
                          QuerySnapshot snap = await FirebaseFirestore.instance
                              .collection("Employee")
                              .where('id', isEqualTo: User.employeeId)
                              .get();

                          await FirebaseFirestore.instance
                              .collection("Employee")
                              .doc(snap.docs[0].id)
                              .update({
                            'address': editController.address.value.text
                          });
                        },
                      ),
                      ProfileScreenField(
                        label: 'Emergency No:',
                        controller: editController.emergencyNo.value,
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

      await FirebaseFirestore.instance
          .collection("Employee")
          .doc(User.id)
          .update({'profile': value});
    });
  }


}
