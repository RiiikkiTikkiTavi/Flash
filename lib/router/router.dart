import 'package:auto_route/auto_route.dart';
import 'package:flash/features/cards/view/card_list_screen.dart';
import 'package:flash/features/learning/view/learning_screen.dart';
import 'package:flash/features/sets/view/set_list_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SetListRoute.page, initial: true),
    AutoRoute(page: CardListRoute.page),
    AutoRoute(page: LearningRoute.page),
  ];
}
