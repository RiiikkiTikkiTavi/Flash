import 'package:flash/features/cards/providers/set_draft_ptovider.dart';
import 'package:flash/talker_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';

class HeaderSetWidget extends ConsumerStatefulWidget {
  const HeaderSetWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HeaderSetWidgetState();
}

class _HeaderSetWidgetState extends ConsumerState<HeaderSetWidget> {
  late final TextEditingController nameController;
  late final TextEditingController descrController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    descrController = TextEditingController();
  }

  void updateDescription(WidgetRef ref, Talker talker) {
    if (descrController.text.trim().isNotEmpty) {
      ref
          .read(setDraftProvider.notifier)
          .updateDescription(descrController.text);
    }
    talker.info('Сохранение description');
  }

  void updateName(Talker talker, WidgetRef ref) {
    if (nameController.text.trim().isNotEmpty) {
      ref.read(setDraftProvider.notifier).updateName(nameController.text);
    }
    talker.info('Сохранение name');
  }

  @override
  Widget build(BuildContext context) {
    final talker = ref.watch(talkerProvider);
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              onEditingComplete: () {
                FocusScope.of(context).nextFocus();
              },
              onChanged: (value) {
                updateName(talker, ref);
              },
              decoration: const InputDecoration(
                hintText: 'Enter name of the set',
                border: UnderlineInputBorder(),
              ),
            ),
            TextField(
              controller: descrController,
              onChanged: (value) {
                updateDescription(ref, talker);
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
