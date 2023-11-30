import 'package:flutter/material.dart';

import 'colorprovider.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({
    super.key,
    required this.themeData,
  });

  final Colorchange themeData;

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, mainAxisSpacing: 5, crossAxisSpacing: 5),
        itemCount: widget.themeData.listofclrs.length,
        itemBuilder: (context, index) {
          bool isSelected = index == widget.themeData.selectedIndex;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  final selectdIndex = index;
                  widget.themeData.setIndex(selectdIndex);
                });
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    color: widget.themeData.listofclrs[index],
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                        color: isSelected ? Colors.black : Colors.transparent)),
              ),
            ),
          );
        },
      ),
    );
  }
}
