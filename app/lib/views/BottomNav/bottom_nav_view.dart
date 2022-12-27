import 'package:app/views/BottomNav/bottom_nav_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class BottomNavView extends StatefulWidget {
  const BottomNavView({super.key});

  @override
  State<BottomNavView> createState() => _BottomNavViewState();
}

class _BottomNavViewState extends State<BottomNavView> {
  int selectedItem = 0;

  void onTapItem(int index) {
    setState(() {
      selectedItem = index;
    });
  }

  // @override
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      builder: ((context, model, child) {
        return Scaffold(
          body: model.pages.elementAt(selectedItem),
          bottomNavigationBar: builtNavigationBar(),
        );
      }),
      viewModelBuilder: () => BottomNavViewModel(),
    );
  }

  Widget builtNavigationBar() => BottomNavigationBar(
        unselectedItemColor: Colors.black45,
        selectedItemColor: Colors.blueAccent,
        currentIndex: selectedItem,
        elevation: 1,
        onTap: onTapItem,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home_max_outlined), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.task_alt), label: ''),
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_identity),
            label: '',
          ),
        ],
      );
}
