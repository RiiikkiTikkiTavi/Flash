import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CardListScreen extends StatelessWidget {
  const CardListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final descrController = TextEditingController();
    final termController = TextEditingController();
    final defController = TextEditingController();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            snap: true,
            floating: true,
            title: const Text('Набор карточек'),
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            actions: [
              IconButton(
                icon: const Icon(Icons.done),
                onPressed: () {
                  context.router.pop();
                },
              ),
            ],
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
              onChanged: (value) {},
              decoration: const InputDecoration(
                hintText: 'Enter name of the set',
                border: UnderlineInputBorder(),
              ),
            ),
            TextField(
              controller: descrController,
              onChanged: (value) {},
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
            onChanged: (value) {},
            decoration: const InputDecoration(
              hintText: 'Enter term',
              border: UnderlineInputBorder(),
            ),
          ),
          TextField(
            controller: defController,
            onChanged: (value) {},
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
