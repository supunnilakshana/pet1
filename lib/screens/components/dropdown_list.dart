import 'package:flutter/material.dart';
import 'package:pet1/screens/components/Textfiledcontainer.dart';
import 'package:pet1/screens/components/constansts.dart';

class DropdownList extends StatefulWidget {
  final List<ListItem> typelist;
  final Function(int?) onchange;
  final Text hinttext;

  const DropdownList({
    Key? key,
    required this.typelist,
    required this.onchange,
    required this.hinttext,
  }) : super(key: key);
  @override
  _DropdownListState createState() => _DropdownListState();
}

class _DropdownListState extends State<DropdownList> {
  int valueitem = 0;
  @override
  Widget build(BuildContext context) {
    return Textfiledcontainer(
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: valueitem,
          items: widget.typelist.map((ListItem item) {
            return DropdownMenuItem<int>(
              child: Text(item.name),
              value: item.value,
            );
          }).toList(),
          onChanged: (int? value) {
            widget.onchange(value);
            setState(() {
              valueitem = value!;
            });
          },
          hint: widget.hinttext,
          elevation: 8,
          style: TextStyle(color: Color(0xFF47476b), fontSize: 16),
          icon: Icon(Icons.arrow_drop_down_circle),
          iconDisabledColor: Colors.red,
          iconEnabledColor: kprimaryColor,
          isExpanded: true,
          dropdownColor: kprimarylightcolor,
        ),
      ),
    );
  }
}

class ListItem {
  int value;
  String name;
  ListItem(this.value, this.name);
}
