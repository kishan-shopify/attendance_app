import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<Map<String, dynamic>>> fetchLeaves() async {
  try {
    List<Map<String, dynamic>> leavesList = [];

    // Reference to the 'Employee' collection
    CollectionReference employees = FirebaseFirestore.instance.collection('Employee');

    // Get all documents from the 'Employee' collection
    QuerySnapshot employeeSnapshot = await employees.get();

    // Iterate through each employee document and get their leaves
    for (QueryDocumentSnapshot employeeDoc in employeeSnapshot.docs) {
      String employeeId = employeeDoc.id;

      // Reference to the 'Leaves' sub-collection within each employee document
      CollectionReference leavesCollection = employees.doc(employeeId).collection('Leaves');

      // Get all documents from the 'Leaves' sub-collection`````````
      QuerySnapshot leavesSnapshot = await leavesCollection.get();

      // Iterate through each leave document and add it to the list
      for (QueryDocumentSnapshot leaveDoc in leavesSnapshot.docs) {
        Map<String, dynamic>? leaveData = leaveDoc.data() as Map<String, dynamic>?;
        leaveData?['employeeId'] = employeeId; // Add employeeId to the leave data
        leavesList.add(leaveData!);
      }
    }

    return leavesList;
  } catch (error) {
    print('Error fetching leaves: $error');
    return [];
  }
}
