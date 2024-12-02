import 'package:carrentapp/data/providers/bloc_car_rent.dart';
import 'package:carrentapp/data/providers/bloc_user_data_global.dart';
import 'package:carrentapp/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const BlocsProvider());
}

class BlocsProvider extends StatelessWidget {
  const BlocsProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => BlocUserDataGlobal()),
        BlocProvider(create: (_) => BlocCarRent()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Car Rent App',
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        secondaryHeaderColor: Colors.blue,
        colorScheme: const ColorScheme.light(
          primary: Color(0xff3563E9),
          secondary: Color(0xff3563E9),
        ),
        fontFamily: 'PlusRegular',
      ),
    );
  }
}
