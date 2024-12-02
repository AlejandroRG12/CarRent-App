import 'package:carrentapp/data/providers/bloc_user_data_global.dart';
import 'package:carrentapp/routes/routes.dart';
import 'package:carrentapp/services/controller/renta_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AllRentsView extends StatefulWidget {
  const AllRentsView({super.key});

  @override
  State<AllRentsView> createState() => _AllRentsViewState();
}

class _AllRentsViewState extends State<AllRentsView> {
  Future<Map<String, dynamic>> getRentas = RentaController().getAllRentas();

  List<dynamic> vehiculos = [];

  loadRentas() {
    getRentas = RentaController().getAllRentas();
  }

  reloadRentas() {
    setState(() {
      getRentas = RentaController().getAllRentas();
    });
  }

  returnDataforVehiculos() async {
    final data = await getRentas;
    if (data['code'] == 200) {
      print(data['data']);
      setState(() {
        vehiculos = data['data'];
      });
    }
  }

  @override
  void initState() {
    loadRentas();
    returnDataforVehiculos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userDataCubic = context.read<BlocUserDataGlobal>();

    return Scaffold(
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              child: Text(userDataCubic.state['nombre'][0] +
                  userDataCubic.state['aPaterno'][0]),
            ),
          ),
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
                    'VEHÍCULOS DISPONIBLES',
                    style: TextStyle(
                      fontFamily: 'PlusBold',
                      fontSize: 20,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      reloadRentas();
                    },
                    icon: const Icon(Icons.refresh),
                  ),
                ],
              ),
              FutureBuilder<Map<String, dynamic>>(
                future: getRentas,
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
                        return rentaView(
                          vehiculo['ciudadOrigen'].toString(),
                          vehiculo['ciudad_dropOff'].toString(),
                          vehiculo['ciudad_pickUp'].toString(),
                          vehiculo['direccionOrigen'].toString(),
                          vehiculo['fecha_dropOff'].toString(),
                          vehiculo['fecha_pickUp'].toString(),
                          vehiculo['id'].toString(),
                          vehiculo['idCliente'].toString(),
                          vehiculo['idVehiculo'].toString(),
                          vehiculo['nombre'].toString(),
                          vehiculo['telefono'].toString(),
                          vehiculo['tiempo_dropOff'].toString(),
                          vehiculo['tiempo_picUp'].toString(),
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

  /* 
    {ciudadOrigen: 1, ciudad_dropOff: Chiapas, ciudad_pickUp: Baja California Sur, direccionOrigen: 1, fecha_dropOff: 2024-12-10 00:00:00.000, fecha_pickUp: 2024-12-01 00:00:00.000, id: 485mfoHrNC3uOBXHKmzU, idCliente: mbcSqXgH3f5mniOXm9kD, idVehiculo: Bejr6veuYQZdqSXbJdzg, nombre: esta es la prueba buena, telefono: 3, tiempo_dropOff: 08:30, tiempo_picUp: 09:00}
   */

  Widget rentaView(
      String? ciudadOrigen,
      String? ciudadDropOff,
      String? ciudadPickUp,
      String? direccionOrigen,
      String? fechaDropOff,
      String? fechaPickUp,
      String? id,
      String? idCliente,
      String? idVehiculo,
      String nombre,
      String? telefono,
      String? tiempoDropOff,
      String? tiempoPicUp) {
    return Container(
      margin: const EdgeInsets.only(right: 20),
      padding: const EdgeInsets.all(20),
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Renta de auto',
            style: TextStyle(
              fontFamily: 'PlusBold',
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Nombre: $nombre',
            style: const TextStyle(
              fontFamily: 'PlusBold',
              fontSize: 12,
              color: Color(0xff90A3BF),
            ),
          ),
          Text(
            'Telefono: $telefono',
            style: const TextStyle(
              fontFamily: 'PlusBold',
              fontSize: 12,
              color: Color(0xff90A3BF),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Fecha de recogida: $fechaPickUp',
            style: const TextStyle(
              fontFamily: 'PlusBold',
              fontSize: 12,
              color: Color(0xff90A3BF),
            ),
          ),
          Text(
            'Hora de recogida: $tiempoPicUp',
            style: const TextStyle(
              fontFamily: 'PlusBold',
              fontSize: 12,
              color: Color(0xff90A3BF),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Fecha de entrega: $fechaDropOff',
            style: const TextStyle(
              fontFamily: 'PlusBold',
              fontSize: 12,
              color: Color(0xff90A3BF),
            ),
          ),
          Text(
            'Hora de entrega: $tiempoDropOff',
            style: const TextStyle(
              fontFamily: 'PlusBold',
              fontSize: 12,
              color: Color(0xff90A3BF),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Dirección de recogida: $direccionOrigen',
            style: const TextStyle(
              fontFamily: 'PlusBold',
              fontSize: 12,
              color: Color(0xff90A3BF),
            ),
          ),
          const SizedBox(width: 5),
          Text(
            '$ciudadOrigen - $ciudadDropOff',
            style: const TextStyle(
              fontFamily: 'PlusBold',
              fontSize: 12,
              color: Color(0xff90A3BF),
            ),
          ),
          Text(
            'ID: $id',
            style: const TextStyle(
              fontFamily: 'PlusBold',
              fontSize: 12,
              color: Color(0xff90A3BF),
            ),
          ),
        ],
      ),
    );
  }
}
