// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MultiSelectChip extends StatefulWidget {
  final List<String> reportList;
  final Function(List<String>) onSelectionChanged;
  const MultiSelectChip({
    Key? key,
    required this.reportList,
    required this.onSelectionChanged,
  }) : super(key: key);

  @override
  State<MultiSelectChip> createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  List<String> selectdChoices = [];

  List<Widget> _builtChoiceList() {
    List<Widget> choices = [];
    widget.reportList.forEach((element) {
      choices.add(Container(
        padding: const EdgeInsets.all(2),
        child: ChoiceChip(
          selectedColor: Colors.blueAccent,
          label: Text(element),
          selected: selectdChoices.contains(element),
          onSelected: (value) {
            setState(() {
              selectdChoices.contains(element)
                  ? selectdChoices.remove(element)
                  : selectdChoices.add(element);
              widget.onSelectionChanged(selectdChoices);
            });
          },
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: _builtChoiceList(),
    );
  }
}
