// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'package:app/views/all_products/all_product_view_model.dart';
import 'package:app/views/all_products/widget/multi_select_chip.dart';

class BottomSheetWidget extends StatefulWidget {
  final AllProductViewModel model;
  final VoidCallback onFilter;
  final VoidCallback onClose;
  final VoidCallback onReset;
  final String title;
  const BottomSheetWidget({
    Key? key,
    required this.model,
    required this.onFilter,
    required this.onClose,
    required this.onReset,
    required this.title,
  }) : super(key: key);

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          builtPriceFilter(),
          builtMultiSelectChips(),
          builtButtons(),
        ],
      ),
    );
  }

  Widget builtMultiSelectChips() => Center(
        child: MultiSelectChip(
          reportList: const [
            'men',
            'women',
            'kids',
          ],
          onSelectionChanged: (categories) {
            widget.model.setCategories(categories);
          },
        ),
      );
  Widget builtPriceFilter() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              const Text('min : '),
              DropdownButton(
                value: widget.model.minValue,
                items: widget.model.min
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  widget.model.setMinValue(value!);
                  setState(() {});
                },
              ),
            ],
          ),
          Row(
            children: [
              const Text('max : '),
              DropdownButton(
                value: widget.model.maxValue,
                items: widget.model.max
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  widget.model.setMaxValue(value!);
                  setState(() {});
                },
              ),
            ],
          ),
        ],
      );
  Widget builtButtons() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
            onPressed: widget.onClose,
            child: const Text(
              'Close',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: widget.onReset,
            child: const Text(
              'Rest',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: widget.onFilter,
            child: const Text(
              'Filter',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
}
