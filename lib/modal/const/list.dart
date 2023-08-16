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