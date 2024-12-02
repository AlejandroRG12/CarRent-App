import 'package:carrentapp/data/providers/bloc_user_data_global.dart';
import 'package:carrentapp/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeAdmView extends StatefulWidget {
  const HomeAdmView({super.key});

  @override
  State<HomeAdmView> createState() => _HomeAdmViewState();
}

class _HomeAdmViewState extends State<HomeAdmView> {
  @override
  Widget build(BuildContext context) {
    final userDataCubic = context.read<BlocUserDataGlobal>();
    return Scaffold(
      backgroundColor: const Color(0xffF6F7F9),
      appBar: AppBar(
        backgroundColor: const Color(0xffF6F7F9),
        title: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: const Image(image: AssetImage('assets/img/logoMoret.png'))),
        actions: [
          IconButton(
              onPressed: () {
                userDataCubic.resetUserDataGlobal();
                context.go(Routes.login);
              },
              icon: const Icon(Icons.login_rounded)),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              title(),
              const WidgetViewAllRents(),
              customListView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget customListView() {
    return SizedBox(
      height: 230,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          actionButton('Agregar Auto', Icons.add, () {
            context.push(Routes.addCar);
          }),
          const SizedBox(width: 10),
          actionButton('Ver Autos', Icons.car_rental, () {
            context.push(Routes.allCars);
          }),
          const SizedBox(width: 10),
          actionButton('Ver Rentas', Icons.car_repair, () {
            context.push(Routes.allRents);
          }),
        ],
      ),
    );
  }

  Widget actionButton(String titulo, IconData icono, void Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 200,
        width: MediaQuery.of(context).size.width * 0.33,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icono,
              size: 50,
              color: const Color(0xff90A3BF),
            ),
            Text(
              titulo,
              style: const TextStyle(
                fontFamily: 'PlusBold',
                fontSize: 20,
                color: Color(0xff90A3BF),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget title() {
    final userDataCubic = context.watch<BlocUserDataGlobal>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Bienvenido ${userDataCubic.state['nombre']}',
          style: const TextStyle(
            fontFamily: 'PlusBold',
            fontSize: 25,
          ),
        ),
        const Text(
          'Admin Panel',
          style: TextStyle(
            fontSize: 18,
            color: Color(0xff90A3BF),
          ),
        ),
      ],
    );
  }
}

class WidgetViewAllRents extends StatefulWidget {
  const WidgetViewAllRents({super.key});

  @override
  State<WidgetViewAllRents> createState() => _WidgetViewAllRentsState();
}

class _WidgetViewAllRentsState extends State<WidgetViewAllRents> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 300,
    );
  }
}
