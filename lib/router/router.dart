import 'package:auto_route/auto_route.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SetListScreen.page, initial: true),
    AutoRoute(page: CardListScreen.page),
    AutoRoute(page: LearningScreen.page),
  ];
}
