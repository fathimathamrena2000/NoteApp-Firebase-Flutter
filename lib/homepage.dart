import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_notapp/FB/fbaseservice.dart';
import 'package:firebase_notapp/FB/updatepage.dart';
import 'package:firebase_notapp/colorprovider.dart';
import 'package:firebase_notapp/addnotes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  Fbase fbase = Fbase();

  bool isGridView = true;
  void changeGrid() {
    isGridView = !isGridView;
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<Colorchange>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  changeGrid();
                });
              },
              icon: !isGridView
                  ? const Icon(Icons.grid_on)
                  : const Icon(Icons.list)),
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.logout))
        ],
        title: const Align(
            alignment: Alignment.topLeft,
            child: Text("Notes",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600))),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const Editing(),
          ));
        },
        child: const Icon(Icons.notes_rounded),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("noteapp")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection("notes")
                  .orderBy("timstamp", descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return isGridView
                      ? GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            QueryDocumentSnapshot document =
                                snapshot.data!.docs[index];

                            var id = snapshot.data!.docs[index].id;

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Dismissible(
                                key: ValueKey(id),
                                background: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 100,
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                    ),
                                    child: const Align(
                                        alignment: Alignment.center,
                                        child: Text("Deleted")),
                                  ),
                                ),
                                confirmDismiss:
                                    (DismissDirection direction) async {
                                  return await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text("Confirm"),
                                          content: const Text("Are you sure"),
                                          actions: <Widget>[
                                            ElevatedButton(
                                                onPressed: () =>
                                                    Navigator.of(context)
                                                        .pop(true),
                                                child: const Text("Delete")),
                                            ElevatedButton(
                                                onPressed: () =>
                                                    Navigator.of(context)
                                                        .pop(false),
                                                child: const Text("Cancel")),
                                          ],
                                        );
                                      });
                                },
                                onDismissed: (DismissDirection direction) {
                                  fbase.deletedata(id);
                                  print("dis $direction");
                                },
                                child: Container(
                                  height: 100,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: themeData
                                        .listofclrs[document['colorIndex']],
                                  ),
                                  child: Column(
                                    children: [
                                      Align(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                InkWell(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .push(
                                                              MaterialPageRoute(
                                                        builder: (context) =>
                                                            Update(
                                                          id: id,
                                                          message:
                                                              document['note'],
                                                          currentIndex:
                                                              document[
                                                                  'colorIndex'],
                                                        ),
                                                      ));
                                                    },
                                                    child:
                                                        const Icon(Icons.edit)),
                                                InkWell(
                                                    onTap: () {
                                                      fbase.deletedata(id);
                                                    },
                                                    child: const Icon(
                                                        Icons.delete)),
                                              ],
                                            ),
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(document['note'])),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            QueryDocumentSnapshot document =
                                snapshot.data!.docs[index];

                            var id = snapshot.data!.docs[index].id;

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Dismissible(
                                key: ValueKey(id),
                                background: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 100,
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                    ),
                                    child: const Align(
                                        alignment: Alignment.center,
                                        child: Text("Deleted")),
                                  ),
                                ),
                                confirmDismiss:
                                    (DismissDirection direction) async {
                                  return await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text("Confirm"),
                                          content: const Text("Are you sure"),
                                          actions: <Widget>[
                                            ElevatedButton(
                                                onPressed: () =>
                                                    Navigator.of(context)
                                                        .pop(true),
                                                child: const Text("Delete")),
                                            ElevatedButton(
                                                onPressed: () =>
                                                    Navigator.of(context)
                                                        .pop(false),
                                                child: const Text("Cancel")),
                                          ],
                                        );
                                      });
                                },
                                onDismissed: (DismissDirection direction) {
                                  fbase.deletedata(id);
                                  print("dis $direction");
                                },
                                child: Container(
                                  height: 100,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: themeData
                                        .listofclrs[document['colorIndex']],
                                  ),
                                  child: Column(
                                    children: [
                                      Align(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                InkWell(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .push(
                                                              MaterialPageRoute(
                                                        builder: (context) =>
                                                            Update(
                                                          id: id,
                                                          message:
                                                              document['note'],
                                                          currentIndex:
                                                              document[
                                                                  'colorIndex'],
                                                        ),
                                                      ));
                                                    },
                                                    child:
                                                        const Icon(Icons.edit)),
                                                InkWell(
                                                    onTap: () {
                                                      fbase.deletedata(id);
                                                    },
                                                    child: const Icon(
                                                        Icons.delete)),
                                              ],
                                            ),
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(document['note'])),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ),
    );
  }
}
