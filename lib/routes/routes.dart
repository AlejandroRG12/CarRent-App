import 'package:carrentapp/presentation/addCar/add_new_car.dart';
import 'package:carrentapp/presentation/allCars/all_cars_view.dart';
import 'package:carrentapp/presentation/allRents/all_rents_view.dart';
import 'package:carrentapp/presentation/home/home_view.dart';
import 'package:carrentapp/presentation/login/login_view.dart';
import 'package:carrentapp/presentation/rent/rent_car_view.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static const login = '/';
  static const home = '/home';
  static const rentCar = '/rentCart';
  static const addCar = '/addCar';
  static const allCars = '/allCars';
  static const allRents = '/allRents';
}

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: Routes.home,
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      path: '${Routes.rentCar}:id',
      builder: (context, state) {
        final id = state.pathParameters['id'];
        return RentCarView(id: id);
      },
    ),
    GoRoute(
      path: Routes.addCar,
      builder: (context, state) => const AddNewCar(),
    ),
    GoRoute(
      path: Routes.allCars,
      builder: (context, state) => const AllCarsView(),
    ),
    GoRoute(
      path: Routes.allRents,
      builder: (context, state) => const AllRentsView(),
    ),
  ],
);
