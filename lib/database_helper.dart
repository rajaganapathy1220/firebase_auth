import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseMethods {
  addEmployDetails(Map<String, dynamic> employDetails, String id) async {
    return await FirebaseFirestore.instance
        .collection("Employ")
        .doc(id)
        .set(employDetails);
  }

  Future<Stream<QuerySnapshot>> getEmployDetails() async {
    return await FirebaseFirestore.instance.collection("Employ").snapshots();
  }

  Future updateEmployDetails(String id, Map<String, dynamic> updateInfo) async {
    return await FirebaseFirestore.instance
        .collection('Employ')
        .doc(id)
        .update(updateInfo);
  }

  Future deleteEmployDetails(String Id) async {
    return await FirebaseFirestore.instance
        .collection("Employ")
        .doc(Id)
        .delete();
  }
}
