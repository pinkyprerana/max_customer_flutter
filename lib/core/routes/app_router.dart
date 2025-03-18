import 'package:auto_route/auto_route.dart';
import '../../screens/add_customer_screen.dart';
import '../../screens/customer_list_screen.dart';
import '../../screens/login_screen.dart';
part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page|Screen,Route')
class AppRouter extends RootStackRouter {
  AppRouter({super.navigatorKey});

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: LoginRoute.page,
      path: '/login',
      initial: true,
    ),
    AutoRoute(
      page: CustomerListRoute.page,
      path: '/customerList',
    ),
    AutoRoute(
      page: AddCustomerRoute.page,
      path: '/addCustomer',
    ),
  ];
}
