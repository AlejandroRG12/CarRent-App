import 'package:carrentapp/core/helpers/cities_data.dart';
import 'package:carrentapp/core/helpers/time_data.dart';
import 'package:carrentapp/core/widgets/global_widgets.dart';
import 'package:carrentapp/data/providers/bloc_car_rent.dart';
import 'package:carrentapp/data/providers/bloc_user_data_global.dart';
import 'package:carrentapp/presentation/home/home_adm_view.dart';
import 'package:carrentapp/presentation/home/widgets/card_car.dart';
import 'package:carrentapp/routes/routes.dart';
import 'package:carrentapp/services/controller/cars_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  //antes de iniciar la vista traer ejecutar getAllVehiculos
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
    final carRentCubic = context.read<BlocCarRent>();

    if (userDataCubic.state['rol'] == 'super admin') {
      return const HomeAdmView();
    }

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
      backgroundColor: const Color(0xffF6F7F9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                const RentCar(),
                const SizedBox(height: 20),
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
                          return cardCar(
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
                            onTap: () {
                              if (validarCamposVacios()) {
                                carRentCubic.idVehiculo(vehiculo['id']);
                                carRentCubic
                                    .idCliente(userDataCubic.state['id']);
                                context.push(Routes.rentCar + vehiculo['id']);
                              } else {
                                notificationPop(
                                    context,
                                    'Por favor llena todos los campos de pickUp y dropOff',
                                    Colors.red);
                              }
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
      ),
    );
  }

  validarCamposVacios() {
    final carRentCubic = context.read<BlocCarRent>();
    if (carRentCubic.state['ciudad_pickUp'] == '' ||
        carRentCubic.state['fecha_pickUp'] == '' ||
        carRentCubic.state['tiempo_picUp'] == '' ||
        carRentCubic.state['ciudad_dropOff'] == '' ||
        carRentCubic.state['fecha_dropOff'] == '' ||
        carRentCubic.state['tiempo_dropOff'] == '') {
      return false;
    } else {
      return true;
    }
  }
}

class RentCar extends StatefulWidget {
  const RentCar({super.key});

  @override
  State<RentCar> createState() => _RentCarState();
}

class _RentCarState extends State<RentCar> {
  String? pickUpselectedCity;
  String? pickUpselectedTime;
  DateTime? pickUpselectedDate;
  String? dropOffselectedCity;
  String? dropOffselectedTime;
  DateTime? dropOffselectedDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        pickUpSelector(),
        const SizedBox(width: 20),
        swapIcon(),
        const SizedBox(width: 20),
        dropOffSelector(),
      ],
    );
  }

  Widget dropOffSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(96, 144, 163, 191),
            offset: Offset(0, 3),
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title('Drop-Off', 'assets/icons/dropOfIcon.svg'),
                const SizedBox(height: 20),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    citiesSelector(false),
                    const SizedBox(width: 5),
                    divicion(),
                    const SizedBox(width: 5),
                    dateSelector(false),
                    const SizedBox(width: 5),
                    divicion(),
                    const SizedBox(width: 5),
                    timeSelector(false)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void carRentData() {
    final carRentCubic = context.watch<BlocCarRent>();
    carRentCubic.setCarRent({
      'pickUpselectedCity': pickUpselectedCity,
      'pickUpselectedTime': pickUpselectedTime,
      'pickUpselectedDate': pickUpselectedDate,
      'dropOffselectedCity': dropOffselectedCity,
      'dropOffselectedTime': dropOffselectedTime,
      'dropOffselectedDate': dropOffselectedDate,
    });
  }

  Widget pickUpSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(96, 144, 163, 191),
            offset: Offset(0, 3),
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title('Pick-Up', 'assets/icons/pickUpIcon.svg'),
                const SizedBox(height: 20),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    citiesSelector(true),
                    const SizedBox(width: 5),
                    divicion(),
                    const SizedBox(width: 5),
                    dateSelector(true),
                    const SizedBox(width: 5),
                    divicion(),
                    const SizedBox(width: 5),
                    timeSelector(true)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget timeSelector(bool isPickUp) {
    final carRentCubic = context.read<BlocCarRent>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Tiempo',
            style: TextStyle(fontFamily: 'PlusBold', fontSize: 22)),
        DropdownButton<String>(
          value: isPickUp ? pickUpselectedTime : dropOffselectedTime,
          hint: const Text(
            'Time',
            style: TextStyle(
              fontFamily: 'PlusRegular',
              color: Color(0xff90A3BF),
            ),
            textAlign: TextAlign.left,
          ),
          items: TimeData.time.map((String time) {
            return DropdownMenuItem<String>(
              value: time,
              child: Text(time,
                  style: const TextStyle(
                      fontFamily: 'PlusRegular', color: Colors.black)),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              /*  isPickUp
                  ? pickUpselectedTime = newValue
                  : dropOffselectedTime = newValue; */
              if (isPickUp) {
                pickUpselectedTime = newValue;
                carRentCubic.tiempoPicUp(newValue.toString());
              } else {
                dropOffselectedTime = newValue;
                carRentCubic.tiempoDropOff(newValue.toString());
              }
            });
          },
          menuMaxHeight: 300,
        ),
      ],
    );
  }

  Widget dateSelector(bool isPickUp) {
    final carRentCubic = context.read<BlocCarRent>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text('Selecciona una fecha',
            style: TextStyle(fontFamily: 'PlusBold', fontSize: 22)),
        const SizedBox(height: 15),
        InkWell(
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: isPickUp
                  ? pickUpselectedDate ?? DateTime.now()
                  : dropOffselectedDate ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            if (picked != null &&
                (isPickUp
                    ? picked != pickUpselectedDate
                    : picked != dropOffselectedDate)) {
              setState(() {
                if (isPickUp) {
                  pickUpselectedDate = picked;
                  carRentCubic.fechaPickUp(picked.toString());
                } else {
                  dropOffselectedDate = picked;
                  carRentCubic.fechaDropOff(picked.toString());
                }
              });
            }
          },
          child: Text(
            isPickUp
                ? pickUpselectedDate != null
                    ? "${pickUpselectedDate!.day}/${pickUpselectedDate!.month}/${pickUpselectedDate!.year}"
                    : 'Selecciona una fecha'
                : dropOffselectedDate != null
                    ? "${dropOffselectedDate!.day}/${dropOffselectedDate!.month}/${dropOffselectedDate!.year}"
                    : 'Selecciona una fecha',
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget citiesSelector(bool isPickUp) {
    final carRentCubic = context.read<BlocCarRent>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Locations',
            style: TextStyle(fontFamily: 'PlusBold', fontSize: 22)),
        DropdownButton<String>(
          value: isPickUp ? pickUpselectedCity : dropOffselectedCity,
          hint: const Text(
            'Selecciona una ciudad',
            style: TextStyle(
              fontFamily: 'PlusRegular',
              color: Color(0xff90A3BF),
            ),
            textAlign: TextAlign.left,
          ),
          items: CitiesData.cities.map((String city) {
            return DropdownMenuItem<String>(
              value: city,
              child: Text(city,
                  style: const TextStyle(
                      fontFamily: 'PlusRegular', color: Colors.black)),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              /* isPickUp
                  ? pickUpselectedCity = newValue
                  : dropOffselectedCity = newValue; */
              if (isPickUp) {
                pickUpselectedCity = newValue;
                carRentCubic.ciudadPickUp(newValue.toString());
              } else {
                dropOffselectedCity = newValue;
                carRentCubic.ciudadDropOff(newValue.toString());
              }
            });
          },
          menuMaxHeight: 300,
        ),
      ],
    );
  }

  swapIcon() {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xff3563E9),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(96, 144, 163, 191),
              offset: Offset(0, 3),
              blurRadius: 6,
            ),
          ]),
      padding: const EdgeInsets.all(20),
      child: const Icon(Icons.swap_calls_rounded, color: Colors.white),
    );
  }

  divicion() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: 70,
      width: 1,
      color: const Color.fromARGB(96, 144, 163, 191),
    );
  }

  title(String title, String image) {
    return Row(
      children: [
        SvgPicture.asset(
          image,
          height: 20,
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(fontFamily: 'PlusBold'),
        ),
      ],
    );
  }
}
