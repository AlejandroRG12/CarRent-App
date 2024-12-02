import 'package:animate_do/animate_do.dart';
import 'package:carrentapp/core/widgets/global_widgets.dart';
import 'package:carrentapp/data/providers/bloc_user_data_global.dart';
import 'package:carrentapp/routes/routes.dart';
import 'package:carrentapp/services/controller/cars_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddNewCar extends StatefulWidget {
  const AddNewCar({super.key});

  @override
  State<AddNewCar> createState() => _AddNewCarState();
}

class _AddNewCarState extends State<AddNewCar> {
  TextEditingController nombreController = TextEditingController();
  TextEditingController modeloController = TextEditingController();
  TextEditingController marcaController = TextEditingController();
  TextEditingController tamanioTanqueController = TextEditingController();
  TextEditingController precioPorRentaController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();

  List tipoDeTransmision = [
    'Automática',
    'Manual',
    'Electrica',
    'Hibrida',
  ];
  String transmision = 'Automática';
  List capacidadList = [
    '2',
    '4',
    '5',
    '6',
    '7',
    '8',
  ];
  String capacidad = '2';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F7F9),
      appBar: customAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              formulario(),
              banner(),
            ],
          ),
        ),
      ),
    );
  }

  agregarVehiculo() async {
    final data = await CarsController().addVehiculo(
        nombreController.text,
        modeloController.text,
        marcaController.text,
        [],
        tamanioTanqueController.text,
        transmision,
        capacidad,
        precioPorRentaController.text,
        descripcionController.text);
    if (data['code'] == 201) {
      notificacion('Vehículo agregado correctamente', Colors.green);
    } else {
      notificacion('Error al agregar el vehículo', Colors.red);
    }
  }

  Widget formulario() {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ]),
      child: Column(
        children: [
          inputFieldWidget(
              labelText: 'Nombre',
              controller: nombreController,
              colorText: Colors.black,
              textType: TextInputType.text,
              icon: Icons.car_rental,
              obscureText: false),
          const SizedBox(height: 20),
          inputFieldWidget(
              labelText: 'Modelo',
              controller: modeloController,
              colorText: Colors.black,
              textType: TextInputType.text,
              icon: Icons.car_crash_rounded,
              obscureText: false),
          const SizedBox(height: 20),
          inputFieldWidget(
              labelText: 'Marca',
              controller: marcaController,
              colorText: Colors.black,
              textType: TextInputType.text,
              icon: Icons.car_repair,
              obscureText: false),
          const SizedBox(height: 20),
          inputFieldWidget(
              labelText: 'Tamaño del tanque',
              controller: tamanioTanqueController,
              colorText: Colors.black,
              textType: TextInputType.text,
              icon: Icons.oil_barrel_rounded,
              obscureText: false),
          const SizedBox(height: 20),
          Container(
            height: 55,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(18),
            ),
            child: DropdownButton(
              dropdownColor: Colors.blue[100],
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              value: transmision,
              items: tipoDeTransmision.map((value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  transmision = value.toString();
                });
              },
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: 55,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(18),
            ),
            child: DropdownButton(
              value: capacidad,
              items: capacidadList.map((value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  capacidad = value.toString();
                });
              },
            ),
          ),
          const SizedBox(height: 20),
          inputFieldWidget(
              labelText: 'Precio por renta',
              controller: precioPorRentaController,
              colorText: Colors.black,
              textType: TextInputType.text,
              icon: Icons.money,
              obscureText: false),
          const SizedBox(height: 20),
          inputFieldWidget(
              labelText: 'Descripción',
              controller: descripcionController,
              colorText: Colors.black,
              textType: TextInputType.text,
              icon: Icons.description,
              obscureText: false),
          const SizedBox(height: 20),
          InkResponse(
            onTap: agregarVehiculo,
            child: Container(
              width: double.infinity,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Agregar Vehículo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'PlusRegular',
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget banner() {
    return Container(
      width: (MediaQuery.of(context).size.width / 2) - 60,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            'Agregar un nuevo vehículo',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontFamily: 'PlusBold',
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Agrega un nuevo vehículo a la lista de vehículos disponibles para renta',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'PlusRegular',
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          FadeInLeft(
            duration: const Duration(milliseconds: 1500),
            child: const Image(
              image: AssetImage('assets/img/camionera.png'),
              //Centrar la imagen
              alignment: Alignment.center,
              height: 250,
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget customAppBar() {
    final userDataCubic = context.read<BlocUserDataGlobal>();
    return AppBar(
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            child: Text(userDataCubic.state['nombre'][0] +
                userDataCubic.state['aPaterno'][0]),
          ),
        ),
      ],
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> notificacion(
      String message, Color color) {
    return notificationPop(context, message, color);
  }
}
