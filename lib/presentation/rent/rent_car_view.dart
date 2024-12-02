import 'package:carrentapp/core/widgets/global_widgets.dart';
import 'package:carrentapp/data/providers/bloc_car_rent.dart';
import 'package:carrentapp/data/providers/bloc_user_data_global.dart';
import 'package:carrentapp/presentation/rent/widgets/widgets_rent_car.dart';
import 'package:carrentapp/routes/routes.dart';
import 'package:carrentapp/services/controller/cars_controller.dart';
import 'package:carrentapp/services/controller/pago_controller.dart';
import 'package:carrentapp/services/controller/renta_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class RentCarView extends StatefulWidget {
  const RentCarView({super.key, required this.id});
  final dynamic id;

  @override
  State<RentCarView> createState() => _RentCarViewState();
}

class _RentCarViewState extends State<RentCarView> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController cardNumber = TextEditingController();
  TextEditingController expirationDate = TextEditingController();
  TextEditingController cardHolder = TextEditingController();
  TextEditingController cvc = TextEditingController();

  late Future<Map<String, dynamic>> vehiculo;
  late Future<Map<String, dynamic>> renta;
  String idRenta = '';
  int? statusRenta;

  bool confirmation = false;
  double montoTotal = 0;

  @override
  void initState() {
    super.initState();
    vehiculo = returnVehicleData();
  }

  Future<Map<String, dynamic>> returnVehicleData() async {
    final data = await CarsController().getVehiculoById(widget.id);
    if (data['code'] == 200) {
      return data['data'];
    } else {
      throw Exception('Error al obtener los datos del vehículo');
    }
  }

  String calcularMontoTotal(String precio) {
    final carRentCubic = context.read<BlocCarRent>();
    final String fechaPickup = carRentCubic.state['fecha_pickUp'];
    final String fechaDropOff = carRentCubic.state['fecha_dropOff'];

    // Parsear las fechas
    final DateTime picUpDate = DateTime.parse(fechaPickup);
    final DateTime dropOffDate = DateTime.parse(fechaDropOff);

    // Calcular la diferencia en días
    final int totalDias = dropOffDate.difference(picUpDate).inDays;

    // Calcular el monto total
    final double precioPorDia = double.parse(precio);
    montoTotal = (totalDias + 1) * precioPorDia;

    // Retornar el monto total como cadena
    return montoTotal.toStringAsFixed(2);
  }

  Future<Map<String, dynamic>> postRenta() async {
    final carRentCubic = context.read<BlocCarRent>();
    final userDataCubic = context.read<BlocUserDataGlobal>();
    final String idCliente = userDataCubic.state['id'];
    final String idVehiculo = carRentCubic.state['idVehiculo'];
    final String nombre = name.text;
    final String telefono = phone.text;
    final String direccion = address.text;
    final String ciudad = city.text;
    final String ciudadPickUp = carRentCubic.state['ciudad_pickUp'];
    final String fechaPickUp = carRentCubic.state['fecha_pickUp'];
    final String tiempoPicUp = carRentCubic.state['tiempo_picUp'];
    final String ciudadDropOff = carRentCubic.state['ciudad_dropOff'];
    final String fechaDropOff = carRentCubic.state['fecha_dropOff'];
    final String tiempoDropOff = carRentCubic.state['tiempo_dropOff'];
    final data = await RentaController().postRenta(
      idCliente,
      idVehiculo,
      nombre,
      telefono,
      direccion,
      ciudad,
      ciudadPickUp,
      fechaPickUp,
      tiempoPicUp,
      ciudadDropOff,
      fechaDropOff,
      tiempoDropOff,
    );
    if (data['code'] == 201) {
      idRenta = data['data']['id'];
      statusRenta = data['code'];
      return data;
    } else {
      notificationPop(context, 'Error en la peticion', Colors.black);
      return {};
    }
  }

  Future<Map<String, dynamic>> postPago() {
    final String targetaNumero = cardNumber.text;
    final String targetaExpiracion = expirationDate.text;
    final String targetaPropietario = cardHolder.text;
    final String targetaCvc = cvc.text;
    final String montoTotal = this.montoTotal.toStringAsFixed(2);
    final String fecha = DateTime.now().toString();
    return PagoController().postPago(
      idRenta,
      targetaNumero,
      targetaExpiracion,
      targetaPropietario,
      targetaCvc,
      montoTotal,
      fecha,
    );
  }

  @override
  Widget build(BuildContext context) {
    final userDataCubic = context.read<BlocUserDataGlobal>();
    //final carRentCubic = context.read<BlocCarRent>();
    return Scaffold(
      backgroundColor: const Color(0xffF6F7F9),
      appBar: AppBar(
        backgroundColor: const Color(0xffF6F7F9),
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: const Image(
            image: AssetImage('assets/img/logoMoret.png'),
          ),
        ),
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
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    cardImages('assets/img/nissanGTR.png', 'Nissan GTR',
                        'Modelo 2021'),
                    Column(
                      children: [
                        FutureBuilder<Map<String, dynamic>>(
                          future: vehiculo,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final data = snapshot.data!;
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  cardInfoCar(
                                    context,
                                    data['nombre'] ?? 'Nombre',
                                    data['descripcion'] ?? 'Descripción',
                                    4,
                                    data['modelo'] ?? 'Modelo',
                                    data['capacidad'] ?? 'Capacidad',
                                    data['tipoDeTransmision'] ?? 'Transmisión',
                                    data['tamanioTanque'] ?? '0',
                                    calcularMontoTotal(
                                        data['precioPorRenta'].toString()),
                                  ),
                                ],
                              );
                            } else if (snapshot.hasError) {
                              return const Text(
                                  'Error al obtener los datos del vehículo');
                            }
                            return const CircularProgressIndicator();
                          },
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        Row(
                          children: [
                            personalInfo(),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.02),
                            paymentMethod(),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.02),
                        confirmationSection(),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  salir() {
    context.pop();
  }

  verificarCamposNoVacios() {
    if (name.text.isNotEmpty &&
        phone.text.isNotEmpty &&
        address.text.isNotEmpty &&
        city.text.isNotEmpty &&
        cardNumber.text.isNotEmpty &&
        expirationDate.text.isNotEmpty &&
        cardHolder.text.isNotEmpty &&
        cvc.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Widget confirmationSection() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Confirmación de renta',
            style: TextStyle(
              fontFamily: 'PlusBold',
              fontSize: 20,
            ),
          ),
          const Text(
            '¡Estamos llegando al final! ¡Solo unos clics más y tu renta estará lista!',
            style: TextStyle(
              fontFamily: 'PlusRegular',
              fontSize: 17,
              color: Color(0xff90A3BF),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: const Color(0xffF6F7F9),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  value: confirmation,
                  onChanged: (value) {
                    setState(() {
                      confirmation = value!;
                    });
                  },
                ),
                const Text(
                  'Acepto los términos y condiciones, así como la política de privacidad.',
                  style: TextStyle(
                    fontFamily: 'PlusRegular',
                    fontSize: 17,
                    color: Color(0xff90A3BF),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              if (confirmation && verificarCamposNoVacios()) {
                postRenta().then((value) {
                  if (value['code'] == 201) {
                    postPago().then((value) {
                      if (value['code'] == 201) {
                        notificationPop(
                            context,
                            '¡Renta realizada con éxito! Su número de renta es: $idRenta',
                            Colors.green);
                        salir();
                      } else {
                        notificationPop(
                            context, 'Error al realizar el pago', Colors.red);
                      }
                    });
                  } else {
                    notificationPop(context, 'Error al realizar la recervacion',
                        Colors.red);
                  }
                });
              } else {
                if (confirmation == false) {
                  notificationPop(
                      context,
                      'Por favor, acepte los términos y condiciones para continuar.',
                      Colors.red);
                } else if (verificarCamposNoVacios() == false) {
                  notificationPop(
                      context,
                      'Por favor, llene todos los campos para continuar.',
                      Colors.red);
                }
              }
            },
            child: Container(
              width: double.infinity,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Confirmar renta',
                style: TextStyle(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget paymentMethod() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.29,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Método de pago',
                style: TextStyle(
                  fontFamily: 'PlusBold',
                  fontSize: 20,
                ),
              ),
              const SizedBox(width: 10),
              SvgPicture.asset(
                'assets/icons/credit-card.svg',
                height: 20,
              ),
            ],
          ),
          const Text(
            'Por favor, ingrese sus datos de pago para continuar con el proceso de renta.',
            style: TextStyle(
              fontFamily: 'PlusRegular',
              fontSize: 17,
              color: Color(0xff90A3BF),
            ),
          ),
          const SizedBox(height: 20),
          inputFieldWidget(
            labelText: 'Número de tarjeta',
            colorText: const Color(0xff90A3BF),
            icon: Icons.credit_card_rounded,
            textType: TextInputType.number,
            controller: cardNumber,
            obscureText: false,
          ),
          const SizedBox(height: 20),
          inputFieldWidget(
            labelText: 'Fecha de expiración',
            colorText: const Color(0xff90A3BF),
            icon: Icons.calendar_today_rounded,
            textType: TextInputType.datetime,
            controller: expirationDate,
            obscureText: false,
          ),
          const SizedBox(height: 20),
          inputFieldWidget(
            labelText: 'Nombre del titular',
            colorText: const Color(0xff90A3BF),
            icon: Icons.person,
            textType: TextInputType.text,
            controller: cardHolder,
            obscureText: false,
          ),
          const SizedBox(height: 20),
          inputFieldWidget(
            labelText: 'CVC',
            colorText: const Color(0xff90A3BF),
            icon: Icons.lock_rounded,
            textType: TextInputType.number,
            controller: cvc,
            obscureText: true,
          ),
        ],
      ),
    );
  }

  Widget personalInfo() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.29,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Información personal',
            style: TextStyle(
              fontFamily: 'PlusBold',
              fontSize: 20,
            ),
          ),
          const Text(
            'Por favor, ingrese sus datos personales para continuar con el proceso de renta.',
            style: TextStyle(
              fontFamily: 'PlusRegular',
              fontSize: 17,
              color: Color(0xff90A3BF),
            ),
          ),
          const SizedBox(height: 20),
          inputFieldWidget(
            labelText: 'Nombre',
            colorText: const Color(0xff90A3BF),
            icon: Icons.person,
            textType: TextInputType.text,
            controller: name,
            obscureText: false,
          ),
          const SizedBox(height: 20),
          inputFieldWidget(
            labelText: 'Número de teléfono',
            colorText: const Color(0xff90A3BF),
            icon: Icons.phone_android_rounded,
            textType: TextInputType.phone,
            controller: phone,
            obscureText: false,
          ),
          const SizedBox(height: 20),
          inputFieldWidget(
            labelText: 'Ciudad',
            colorText: const Color(0xff90A3BF),
            icon: Icons.location_city_rounded,
            textType: TextInputType.text,
            controller: city,
            obscureText: false,
          ),
          const SizedBox(height: 20),
          inputFieldWidget(
            labelText: 'Dirección completa',
            colorText: const Color(0xff90A3BF),
            icon: Icons.house_rounded,
            textType: TextInputType.text,
            controller: address,
            obscureText: false,
          ),
        ],
      ),
    );
  }
}
