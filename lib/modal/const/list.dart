
import '../modal_class/user.dart';
import 'const_image.dart';

List bottomNavBarItems = [
  ConstImage.home,
  ConstImage.attendance,
  ConstImage.notification,
  ConstImage.option,
];

List moreOptionList = [
  ConstImage.profile,
  ConstImage.leaves,
  ConstImage.team,
  ConstImage.changePassword,
  ConstImage.notificationSetting,
  ConstImage.logout,
];

List moreOptionListTitle = [
  "View Profile",
  "Apply for a leave",
  "Discuss with team",
  "Change Password",
  "Notification Settings",
  "Logout"
];

List profilePageList = [
  "Employee ID :-",
  "Email Id :-",
  "Birth Date :-",
  "Joining Date :-",
  "Aadhaar No :-",
  "PAN No :-",
  "Address :-"
];

List profilePageListData = [
  User.employeeId,
  User.mail,
  User.birthdate,
  User.joiningDate,
  User.aadhaarNo,
  User.panNo,
  User.address,
];