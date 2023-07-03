// StreamBuilder<QuerySnapshot>(
// stream: FirebaseFirestore.instance
//     .collection("Employee")
//     .doc(User.id)
//     .collection("Record")
//     .orderBy('date', descending: true) // Order by the "date" field in descending order
//     .snapshots(),
// builder: (BuildContext context,
// AsyncSnapshot<QuerySnapshot> snapshot) {
// if (snapshot.hasData) {
// final snap = snapshot.data!.docs.toList(); // Reverse the document list
//
// final presentDays = snap.where((doc) {
// final date = doc['date'].toDate();
// return DateFormat('MMMM').format(date) == _month; // Exclude records with '--/--' in the checkOut field
// }).toList();
//
// homeController.presentDays = presentDays.length.obs;
//
// log("PRESENT DAY === ${homeController.presentDays}");
// return ListView.builder(
// padding: EdgeInsets.zero,
// itemCount: snap.length,
// itemBuilder: (context, index) {
// return DateFormat('MMMM').format(snap[index]['date'].toDate()) == _month
// ? Container(
// width: size.width,
// margin: const EdgeInsets.only(bottom: 10),
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(12),
// color: ConstColor.white),
// child: Row(
// mainAxisAlignment:
// MainAxisAlignment.spaceBetween,
// children: [
// Expanded(
// child: Row(
// mainAxisAlignment:
// MainAxisAlignment.spaceEvenly,
// children: [
// const SizedBox(
// width: 10,
// ),
// Container(
// margin: const EdgeInsets.symmetric(
// vertical: 10),
// padding: const EdgeInsets.symmetric(
// vertical: 5),
// width: 70,
// decoration: BoxDecoration(
// borderRadius:
// BorderRadius.circular(14),
// color:
// ConstColor.primaryBackGround),
// alignment: Alignment.center,
// child: Column(
// children: [
// Text(
// DateFormat('dd').format(
// snap[index]['date']
//     .toDate()),
// style: TextStyle(
// fontSize: size.width * 0.045,
// color: ConstColor.blackText,
// fontWeight: FontWeight.w700,
// ),
// ),
// Text(
// DateFormat('EE').format(
// snap[index]['date']
//     .toDate()),
// style: TextStyle(
// fontSize: size.width * 0.04,
// color: ConstColor.blackText,
// ),
// ),
// ],
// ),
// ),
// Expanded(child: Container()),
// Container(
// margin: const EdgeInsets.symmetric(
// vertical: 10),
// child: Column(
// children: [
// Text(
// "Punch in",
// style: TextStyle(
// fontSize: size.width * 0.039,
// color: ConstColor.blackText,
// fontWeight: FontWeight.w700,
// ),
// ),
// Text(
// snap[index]['checkIn'],
// style: TextStyle(
// fontSize: size.width * 0.037,
// color: ConstColor.blackText
//     .withOpacity(0.5),
// ),
// ),
// ],
// ),
// ),
// Expanded(child: Container()),
// Container(
// margin: const EdgeInsets.symmetric(
// vertical: 10),
// child: Column(
// children: [
// Text(
// "Punch out",
// style: TextStyle(
// fontSize: size.width * 0.037,
// color: ConstColor.blackText,
// fontWeight: FontWeight.w700,
// ),
// ),
// Text(
// snap[index]['checkOut'],
// style: TextStyle(
// fontSize: size.width * 0.038,
// color: ConstColor.blackText
//     .withOpacity(0.5),
// ),
// ),
// ],
// ),
// ),
// Expanded(child: Container()),
// ],
// ),
// ),
// Container(
// alignment: Alignment.center,
// decoration: BoxDecoration(
// color: ConstColor.red,
// borderRadius: const BorderRadius.only(
// topRight: Radius.circular(11),
// bottomRight: Radius.circular(11),
// ),
// ),
// width: 70,
// height: 80,
// child: Text(
// (snap[index]['checkOut'] == "--/--")
// ? "A"
//     : "B",
// style: TextStyle(
// fontSize: 24,
// fontWeight: FontWeight.w700,
// color: Colors.white),
// ),
// ),
// ],
// ),
// )
//     : const SizedBox();
// },
// );
// } else {
// return const SizedBox();
// }
// },
// ),