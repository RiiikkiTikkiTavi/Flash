// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final descrController = TextEditingController();
    final termController = TextEditingController();
    final defController = TextEditingController();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            snap: true,
            floating: true,
            title: Text('Набор карточек'),
            elevation: 0,
            surfaceTintColor: Colors.transparent,
          ),
          HeaderSetWidget(
            nameController: nameController,
            descrController: descrController,
          ),
          SliverList.builder(
            itemCount: 15,
            itemBuilder: (context, index) {
              return CardWidget(
                termController: termController,
                defController: defController,
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.termController,
    required this.defController,
  });

  final TextEditingController termController;
  final TextEditingController defController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Colors.cyanAccent,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: termController,
            onChanged: (value) {
              print("Current text: $value");
            },
            decoration: const InputDecoration(
              hintText: 'Enter term',
              border: UnderlineInputBorder(),
            ),
          ),
          TextField(
            controller: defController,
            onChanged: (value) {
              print("Current text: $value");
            },
            decoration: const InputDecoration(
              hintText: 'Enter definition',
              border: UnderlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderSetWidget extends StatelessWidget {
  const HeaderSetWidget({
    super.key,
    required this.nameController,
    required this.descrController,
  });

  final TextEditingController nameController;
  final TextEditingController descrController;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              onChanged: (value) {
                print("Current text: $value");
              },
              decoration: const InputDecoration(
                hintText: 'Enter name of the set',
                border: UnderlineInputBorder(),
              ),
            ),
            TextField(
              controller: descrController,
              onChanged: (value) {
                print("Current text: $value");
              },
              decoration: const InputDecoration(
                hintText: 'Enter description of the set',
                border: UnderlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SetListWidget extends StatelessWidget {
  const SetListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Flashcards'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        shrinkWrap: true,
        itemCount: 40,
        itemBuilder: (context, index) {
          return const SetNameWidget(name: 'Set of cards');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

class SetNameWidget extends StatelessWidget {
  const SetNameWidget({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.blueGrey,
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(name, style: const TextStyle(fontSize: 24)),
      ),
    );
  }
}

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
            print("Close pressed");
          },
        ),
        title: const Text('1/11'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              print("Edit pressed");
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              print("Settings pressed");
            },
          ),
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
