import 'package:firebase_notapp/FB/fbaseservice.dart';
import 'package:firebase_notapp/colorpicker.dart';
import 'package:firebase_notapp/colorprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Update extends StatefulWidget {
  final dynamic id;
  final String message;
  final int currentIndex;
  final String description;

  const Update({
    super.key,
    required this.id,
    required this.message,
    required this.description,
    required this.currentIndex,
  });

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  Fbase fbase = Fbase();

  TextEditingController titleCntrler = TextEditingController();
  TextEditingController descCntrler = TextEditingController();

  @override
  void dispose() {
    titleCntrler.dispose();
    descCntrler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<Colorchange>(context, listen: true);
    titleCntrler.text = widget.message;
    descCntrler.text = widget.description;

    return Scaffold(
      backgroundColor: themeData.listofclrs[themeData.selectedIndex],
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Title",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(
            height: 100,
            width: MediaQuery.of(context).size.width * 0.9,
            child: TextField(
              controller: titleCntrler,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: const Text(
              "Description",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(
            height: 100,
            width: MediaQuery.of(context).size.width * 0.9,
            child: TextField(
              controller: descCntrler,
            ),
          ),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return ColorPicker(themeData: themeData);
                },
              );
            },
            child: Container(
              child: Text("showModelbottomsheet"),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.grey),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          String title = titleCntrler.text;
          String desc = descCntrler.text;
          fbase.updatedata(widget.id, title, desc, themeData.selectedIndex);

          titleCntrler.clear();
          Navigator.of(context).pop();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
