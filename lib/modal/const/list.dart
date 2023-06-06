
import 'package:attendance_app/modal/modal_class/leave_class.dart';

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
  "Leaves",
  "Discuss with team",
  "Change Password",
  "Notification Settings",
  "Logout"
];

List profilePageList = [
  "Employee ID :",
  "Email Id :",
  "Mobile No :",
  "Birth Date :",
  "Joining Date :",
  "Blood Group :",
  "Aadhaar No :",
  "PAN No :",
  "Address :",
  "Emergency No :"
];

List profilePageListData = [
  User.employeeId,
  User.mail,
  User.mobile,
  User.birthdate,
  User.joiningDate,
  User.bloodGroup,
  User.aadhaarNo,
  User.panNo,
  User.address,
  User.emergency,
];

List dummyLeaveList = [
  LeaveClass(leaveType: "CL", fromDate: "18 July 2023", toDate: "20 July 2023", reason: ""),
  LeaveClass(leaveType: "FL", fromDate: "18 July 2023", toDate: "20 July 2023", reason: ""),
  LeaveClass(leaveType: "SL", fromDate: "18 July 2023", toDate: "20 July 2023", reason: ""),
  LeaveClass(leaveType: "OTH", fromDate: "18 July 2023", toDate: "20 July 2023", reason: ""),
  LeaveClass(leaveType: "OTH", fromDate: "18 July 2023", toDate: "20 July 2023", reason: ""),
  LeaveClass(leaveType: "CL", fromDate: "18 July 2023", toDate: "20 July 2023", reason: ""),
  LeaveClass(leaveType: "CL", fromDate: "18 July 2023", toDate: "20 July 2023", reason: ""),
  LeaveClass(leaveType: "SL", fromDate: "18 July 2023", toDate: "20 July 2023", reason: ""),
  LeaveClass(leaveType: "SL", fromDate: "18 July 2023", toDate: "20 July 2023", reason: ""),
  LeaveClass(leaveType: "CL", fromDate: "18 July 2023", toDate: "20 July 2023", reason: ""),
  LeaveClass(leaveType: "FL", fromDate: "18 July 2023", toDate: "20 July 2023", reason: ""),
  LeaveClass(leaveType: "CL", fromDate: "18 July 2023", toDate: "20 July 2023", reason: ""),
  LeaveClass(leaveType: "FL", fromDate: "18 July 2023", toDate: "20 July 2023", reason: ""),
];