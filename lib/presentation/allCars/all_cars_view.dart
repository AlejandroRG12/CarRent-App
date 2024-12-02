import 'package:carrentapp/core/core.dart';
import 'package:carrentapp/data/providers/bloc_user_data_global.dart';
import 'package:carrentapp/presentation/allCars/widgets/card_car.dart';
import 'package:carrentapp/routes/routes.dart';
import 'package:carrentapp/services/controller/cars_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AllCarsView extends StatefulWidget {
  const AllCarsView({super.key});

  @override
  State<AllCarsView> createState() => _AllCarsViewState();
}

class _AllCarsViewState extends State<AllCarsView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController sizeTankController = TextEditingController();
  TextEditingController transmissionTypeController = TextEditingController();
  TextEditingController capacityController = TextEditingController();
  TextEditingController pricePerRentController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Future<Map<String, dynamic>> getVehiculos =
      CarsController().getAllVehiculos();

  List<dynamic> vehiculos = [];

  loadVehiculos() {
    getVehiculos = CarsController().getAllVehiculos();
  }

  reloadVehiculos() {
    setState(() {
      getVehiculos = CarsController().getAllVehiculos();
    });
  }

  returnDataforVehiculos() async {
    final data = await getVehiculos;
    if (data['code'] == 200) {
      setState(() {
        vehiculos = data['data'];
      });
    }
  }

  @override
  void initState() {
    loadVehiculos();
    returnDataforVehiculos();
    super.initState();
  }

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
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'VEHÍCULOS REGISTRADOS',
                    style: TextStyle(
                      fontFamily: 'PlusBold',
                      fontSize: 20,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      reloadVehiculos();
                    },
                    icon: const Icon(Icons.refresh),
                  ),
                ],
              ),
              FutureBuilder<Map<String, dynamic>>(
                future: getVehiculos,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!['data'].isEmpty) {
                    return const Center(
                        child: Text('No hay vehículos disponibles'));
                  }
                  final vehiculos = snapshot.data!['data'] as List<dynamic>;
                  return SizedBox(
                    height: 410, // Ajusta según el tamaño de tu cardCar
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: vehiculos.length,
                      itemBuilder: (context, index) {
                        final vehiculo = vehiculos[index];
                        return cardCarEditing(
                          context: context,
                          name: vehiculo['nombre'],
                          model: vehiculo['modelo'],
                          brand: vehiculo['marca'],
                          sizeTank: vehiculo['tamanioTanque'].toString(),
                          transmissionType: vehiculo['tipoDeTransmision'],
                          capacity: vehiculo['capacidad'].toString(),
                          pricePerRent: vehiculo['precioPorRenta'].toString(),
                          description: vehiculo['descripcion'],
                          //imgUrl: vehiculo['imgs'][0], // Usando la primera imagen del array
                          activeMargin: true,
                          margin: 20, // Usando la primera imagen del array
                          editar: () {
                            //capacidad = vehiculo['capacidad'].toString();
                            //transmision = vehiculo['tipoDeTransmision'];
                            digalogoEditar(
                              vehiculo['id'],
                              vehiculo['nombre'],
                              vehiculo['modelo'],
                              vehiculo['marca'],
                              vehiculo['tamanioTanque'].toString(),
                              vehiculo['tipoDeTransmision'],
                              vehiculo['capacidad'].toString(),
                              vehiculo['precioPorRenta'].toString(),
                              vehiculo['descripcion'],
                            );
                          },
                          eliminar: () {
                            digalogoEliminar(vehiculo['id']);
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  digalogoEditar(
      String id,
      String name,
      String model,
      String brand,
      String sizeTank,
      String transmissionType,
      String capacity,
      String pricePerRent,
      String description) {
    TextEditingController nameController = TextEditingController(text: name);
    TextEditingController modelController = TextEditingController(text: model);
    TextEditingController brandController = TextEditingController(text: brand);
    TextEditingController sizeTankController =
        TextEditingController(text: sizeTank);
    TextEditingController pricePerRentController =
        TextEditingController(text: pricePerRent);
    TextEditingController descriptionController =
        TextEditingController(text: description);
    List tipoDeTransmision = [
      'Automática',
      'Manual',
      'Electrica',
      'Hibrida',
    ];
    String transmision = transmissionType;
    List capacidadList = [
      '2',
      '4',
      '5',
      '6',
      '7',
      '8',
    ];
    String capacidad = capacity;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar Vehículo'),
          content: SizedBox(
            width: 500,
            child: Column(
              children: [
                inputFieldWidget(
                    labelText: 'Nombre',
                    controller: nameController,
                    colorText: Colors.black,
                    textType: TextInputType.text,
                    icon: Icons.car_rental,
                    obscureText: false),
                const SizedBox(height: 20),
                inputFieldWidget(
                    labelText: 'Modelo',
                    controller: modelController,
                    colorText: Colors.black,
                    textType: TextInputType.text,
                    icon: Icons.car_crash_rounded,
                    obscureText: false),
                const SizedBox(height: 20),
                inputFieldWidget(
                    labelText: 'Marca',
                    controller: brandController,
                    colorText: Colors.black,
                    textType: TextInputType.text,
                    icon: Icons.car_repair,
                    obscureText: false),
                const SizedBox(height: 20),
                inputFieldWidget(
                    labelText: 'Tamaño del tanque',
                    controller: sizeTankController,
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
                    controller: pricePerRentController,
                    colorText: Colors.black,
                    textType: TextInputType.text,
                    icon: Icons.money,
                    obscureText: false),
                const SizedBox(height: 20),
                inputFieldWidget(
                    labelText: 'Descripción',
                    controller: descriptionController,
                    colorText: Colors.black,
                    textType: TextInputType.text,
                    icon: Icons.description,
                    obscureText: false),
                const SizedBox(height: 20),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                salir();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                // Lógica para editar el vehículo
                final data = await CarsController().updateVehiculo(
                  id,
                  nameController.text,
                  modelController.text,
                  brandController.text,
                  [],
                  sizeTankController.text,
                  transmision,
                  capacidad.toString(),
                  pricePerRentController.text,
                  descriptionController.text,
                );
                if (data['code'] == 200) {
                  notificacion('Vehículo editado', Colors.green);
                  reloadVehiculos();
                } else {
                  notificacion('Error al editar el vehículo', Colors.red);
                }
                salir();
              },
              child: const Text('Editar'),
            ),
          ],
        );
      },
    );
  }

  digalogoEliminar(String id) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Eliminar Vehículo'),
          content: const Text('¿Estás seguro de eliminar este vehículo?'),
          actions: [
            TextButton(
              onPressed: () {
                salir();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                // Lógica para eliminar el vehículo
                final data = await CarsController().deleteVehiculo(id);
                if (data['code'] == 200) {
                  notificacion('Vehículo eliminado', Colors.green);
                  reloadVehiculos();
                } else {
                  notificacion('Error al eliminar el vehículo', Colors.red);
                }
                salir();
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }

  salir() {
    context.pop();
  }

  notificacion(String message, Color color) {
    notificationPop(context, message, color);
  }
}
