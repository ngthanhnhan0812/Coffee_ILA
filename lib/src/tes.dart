import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      title: 'Returning Data',
      home: HomeScreen(),
    ),
  );
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Returning Data Demo'),
      ),
      body: const Center(
        child: SelectionButton(),
      ),
    );
  }
}

class SelectionButton extends StatefulWidget {
  const SelectionButton({super.key});

  @override
  State<SelectionButton> createState() => _SelectionButtonState();
}

class _SelectionButtonState extends State<SelectionButton> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
//     return Scaffold(appBar: TabBar(
//   isScrollable: true, // Required
//   unselectedLabelColor: Colors.white30, // Other tabs color
//   labelPadding: EdgeInsets.symmetric(horizontal: 30), // Space between tabs
//   indicator: UnderlineTabIndicator(
//     borderSide: BorderSide(color: Colors.white, width: 2), // Indicator height
//     insets: EdgeInsets.symmetric(horizontal: 48), // Indicator width
//   ),
//   tabs: [
//     Tab(text: 'Total Investment'),
//     Tab(text: 'Your Earnings'),
//     Tab(text: 'Current Balance'),
//   ],
// ),);
  }

  
}

