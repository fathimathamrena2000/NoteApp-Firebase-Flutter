import 'package:firebase_notapp/FB/fbaseservice.dart';
import 'package:firebase_notapp/colorpicker.dart';
import 'package:firebase_notapp/colorprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Update extends StatefulWidget {
  final dynamic id;
  final String message;
  final int currentIndex;

  const Update({
    super.key,
    required this.id,
    required this.message,
    required this.currentIndex,
  });

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  Fbase fbase = Fbase();

  TextEditingController titleCntrler = TextEditingController();
  @override
  void dispose() {
    titleCntrler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<Colorchange>(context, listen: true);
    titleCntrler.text = widget.message;

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
                fontSize: 30,
                fontWeight: FontWeight.w600,
                color: Colors.black,
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
          fbase.updatedata(widget.id, title, themeData.selectedIndex);

          titleCntrler.clear();
          Navigator.of(context).pop();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
