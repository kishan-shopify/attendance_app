import '../modal_class/leave_class.dart';
import '../modal_class/notification_class.dart';
import 'const_image.dart';

List bottomNavBarItems = [
  ConstImage.home,
  ConstImage.calendar2,
  ConstImage.worksheet,
  ConstImage.menu,
];

List trueBottomNavBarItems = [
  ConstImage.homeFill,
  ConstImage.calendar2Fill,
  ConstImage.worksheetFill,
  ConstImage.menuFill,
];

List moreOptionList = [
  ConstImage.profile,
  ConstImage.team,
  ConstImage.changePassword,
  ConstImage.notificationSetting,
];

List moreOptionListTitle = [
  "View Profile",
  "Leaves",
  "Discuss with team",
  "Change Password",
  "Notification Settings",
  "Logout"
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

List dummyNotificationList = [
  NotificationClass(icon: ConstImage.checkInNotification, title: "Hey, You're getting late, Please hurry up and check in", time: ""),
  NotificationClass(icon: ConstImage.checkOutNotification, title: "Hey, It's time to checkout", time: ""),
  NotificationClass(icon: ConstImage.leaveNotification, title: "Hey, Your leave is approved", time: ""),
  NotificationClass(icon: ConstImage.holidayNotification, title: "Hey, tomorrow is the holiday", time: ""),
  NotificationClass(icon: ConstImage.checkInNotification, title: "Hey, You're getting late, Please hurry up and check in", time: ""),
  NotificationClass(icon: ConstImage.checkOutNotification, title: "Hey, It's time to checkout", time: ""),
  NotificationClass(icon: ConstImage.leaveNotification, title: "Hey, Your leave is approved", time: ""),
  NotificationClass(icon: ConstImage.holidayNotification, title: "Hey, tomorrow is the holiday", time: ""),
  NotificationClass(icon: ConstImage.checkInNotification, title: "Hey, You're getting late, Please hurry up and check in", time: ""),
  NotificationClass(icon: ConstImage.checkOutNotification, title: "Hey, It's time to checkout", time: ""),
  NotificationClass(icon: ConstImage.leaveNotification, title: "Hey, Your leave is approved", time: ""),
  NotificationClass(icon: ConstImage.holidayNotification, title: "Hey, tomorrow is the holiday", time: ""),
];