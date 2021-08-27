import 'package:flutter/material.dart';
import 'package:pet1/screens/components/Textfiledcontainer.dart';
import 'package:pet1/screens/components/constansts.dart';

class DropdownList extends StatefulWidget {
  final List<ListItem> typelist;
  final Function(int?) onchange;
  const DropdownList({
    Key? key,
    required this.typelist,
    required this.onchange,
  }) : super(key: key);
  @override
  _DropdownListState createState() => _DropdownListState();
}

int? _value;

class _DropdownListState extends State<DropdownList> {
  @override
  Widget build(BuildContext context) {
    return Textfiledcontainer(
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: _value,
          items: widget.typelist.map((ListItem item) {
            return DropdownMenuItem<int>(
              child: Text(item.name),
              value: item.value,
            );
          }).toList(),
          onChanged: widget.onchange,
          hint: Text("Select pet's species"),
          elevation: 8,
          style: TextStyle(color: Colors.black, fontSize: 16),
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
