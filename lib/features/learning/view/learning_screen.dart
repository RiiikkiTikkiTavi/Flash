import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class LearningScreen extends StatelessWidget {
  const LearningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            context.router.pop();
          },
        ),
        title: const Text('1/11'),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
          IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CountWidget(color: Colors.orange, isLeft: true, text: '1'),
                CountWidget(color: Colors.cyan, isLeft: false, text: '1'),
              ],
            ),
          ),
          const SizedBox(height: 150),
          Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Colors.lightBlueAccent,
            ),
            height: 290,
            width: 290,
            child: const Text('TERM', style: TextStyle(fontSize: 40)),
          ),
        ],
      ),
    );
  }
}

class CountWidget extends StatelessWidget {
  const CountWidget({
    super.key,
    required this.color,
    required this.isLeft,
    required this.text,
  });

  final Color color;
  final bool isLeft;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color, // Move color here
        borderRadius: isLeft
            ? const BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              )
            : const BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ), // All corners rounded
      ),
      height: 50,
      width: 70,
      child: Text(text, style: const TextStyle(fontSize: 24)),
    );
  }
}
