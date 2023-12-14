import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Fbase {
//   final CollectionReference notesdata =
//       FirebaseFirestore.instance.collection("notes");

//   //add note
//   Future<void> adddata(String titledata) async {
//     notesdata.add({"note": titledata, "timstamp": Timestamp.now()});
//   }

// //to get notes
//   Stream<QuerySnapshot> getnotes() {
//     final notestream =
//         notesdata.orderBy("timstamp", descending: true).snapshots();
//     return notestream;
//   }

// //to edit notes
//   Future<void> editdata(dynamic id, titledata) async {
//     notesdata.doc(id).update({"note": titledata, "timstamp": Timestamp.now()});
//   }

//   //to delete notes
//   Future<void> deletedata(dynamic id) async {
//     notesdata.doc(id).delete();
//   }

  Future<void> adddata(
      String titledata, String descdata, int colorIndex) async {
    FirebaseFirestore.instance
        .collection("noteapp")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("notes")
        .add({
      "note": titledata,
      "desc": descdata,
      'colorIndex': colorIndex,
      "timstamp": Timestamp.now()
    });
  }

  Future<void> updatedata(
      dynamic id, String titledata, String descdata, int colorIndex) async {
    FirebaseFirestore.instance
        .collection("noteapp")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("notes")
        .doc(id)
        .update({
      "note": titledata,
      "desc": descdata,
      'colorIndex': colorIndex,
      "timstamp": Timestamp.now()
    });
  }

  Future<void> deletedata(
    dynamic id,
  ) async {
    FirebaseFirestore.instance
        .collection("noteapp")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("notes")
        .doc(id)
        .delete();
  }
}
