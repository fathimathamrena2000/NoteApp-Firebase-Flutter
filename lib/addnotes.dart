import 'package:firebase_notapp/FB/fbaseservice.dart';
import 'package:firebase_notapp/colorprovider.dart';
import 'package:firebase_notapp/ksackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'colorpicker.dart';

class Editing extends StatefulWidget {
  const Editing({super.key});

  @override
  State<Editing> createState() => _EditingState();
}

class _EditingState extends State<Editing> {
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

    return WillPopScope(
      onWillPop: () async {
        if (titleCntrler.text == '') {
          ScaffoldMessenger.of(context).showSnackBar(titlesnackbar);
        } else if (descCntrler.text == '') {
        } else {
          String title = titleCntrler.text;
          String desc = descCntrler.text;
          fbase.adddata(title, desc, themeData.selectedIndex);

          titleCntrler.clear();
          ScaffoldMessenger.of(context).showSnackBar(savesnackbar);
        }
        return true;
      },
      child: Scaffold(
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
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Description",
                style: TextStyle(
                  fontSize: 20,
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
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (titleCntrler.text == '') {
              ScaffoldMessenger.of(context).showSnackBar(titlesnackbar);
            } else if (descCntrler.text == '') {
            } else {
              String title = titleCntrler.text;
              String desc = descCntrler.text;
              fbase.adddata(title, desc, themeData.selectedIndex);
              titleCntrler.clear();
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(savesnackbar);
            }
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
