import 'package:bloc/bloc.dart';

class BlocCarRent extends Cubit<Map<String, dynamic>> {
  BlocCarRent()
      : super({
          "idCliente": "",
          "idVehiculo": "",
          "nombre": "",
          "telefono": "",
          "direccionOrigen": "",
          "ciudadOrigen": "",
          "ciudad_pickUp": "",
          "fecha_pickUp": "",
          "tiempo_picUp": "",
          "ciudad_dropOff": "",
          "fecha_dropOff": "",
          "tiempo_dropOff": ""
        });

  void setCarRent(Map<String, dynamic> data) {
    final Map<String, dynamic> carRent = {
      "idCliente": data["idCliente"] ?? "",
      "idVehiculo": data["idVehiculo"] ?? "",
      "nombre": data["nombre"] ?? "",
      "telefono": data["telefono"],
      "direccionOrigen": data["direccionOrigen"] ?? "",
      "ciudadOrigen": data["ciudadOrigen"] ?? "",
      "ciudad_pickUp": data["ciudad_pickUp"] ?? "",
      "fecha_pickUp": data["fecha_pickUp"] ?? "",
      "tiempo_picUp": data["tiempo_picUp"],
      "ciudad_dropOff": data["ciudad_dropOff"] ?? "",
      "fecha_dropOff": data["fecha_dropOff"] ?? "",
      "tiempo_dropOff": data["tiempo_dropOff"] ?? ""
    };
    emit(carRent);
  }

  void idCliente(String idCliente) {
    final Map<String, dynamic> carRent = state;
    carRent["idCliente"] = idCliente;
    emit(carRent);
  }

  void idVehiculo(String idVehiculo) {
    final Map<String, dynamic> carRent = state;
    carRent["idVehiculo"] = idVehiculo;
    emit(carRent);
  }

  void nombre(String nombre) {
    final Map<String, dynamic> carRent = state;
    carRent["nombre"] = nombre;
    emit(carRent);
  }

  void telefono(String telefono) {
    final Map<String, dynamic> carRent = state;
    carRent["telefono"] = telefono;
    emit(carRent);
  }

  void direccionOrigen(String direccion) {
    final Map<String, dynamic> carRent = state;
    carRent["direccionOrigen"] = direccion;
    emit(carRent);
  }

  void ciudadOrigen(String ciudad) {
    final Map<String, dynamic> carRent = state;
    carRent["ciudadOrigen"] = ciudad;
    emit(carRent);
  }

  void ciudadPickUp(String ciudad) {
    final Map<String, dynamic> carRent = state;
    carRent["ciudad_pickUp"] = ciudad;
    emit(carRent);
  }

  void fechaPickUp(String fecha) {
    final Map<String, dynamic> carRent = state;
    carRent["fecha_pickUp"] = fecha;
    emit(carRent);
  }

  void tiempoPicUp(String tiempo) {
    final Map<String, dynamic> carRent = state;
    carRent["tiempo_picUp"] = tiempo;
    emit(carRent);
  }

  void ciudadDropOff(String ciudad) {
    final Map<String, dynamic> carRent = state;
    carRent["ciudad_dropOff"] = ciudad;
    emit(carRent);
  }

  void fechaDropOff(String fecha) {
    final Map<String, dynamic> carRent = state;
    carRent["fecha_dropOff"] = fecha;
    emit(carRent);
  }

  void tiempoDropOff(String tiempo) {
    final Map<String, dynamic> carRent = state;
    carRent["tiempo_dropOff"] = tiempo;
    emit(carRent);
  }

  void resetCarRent() {
    final Map<String, dynamic> carRent = {
      "idCliente": "",
      "idVehiculo": "",
      "nombre": "",
      "telefono": "",
      "direccionOrigen": "",
      "ciudadOrigen": "",
      "ciudad_pickUp": "",
      "fecha_pickUp": "",
      "tiempo_picUp": "",
      "ciudad_dropOff": "",
      "fecha_dropOff": "",
      "tiempo_dropOff": ""
    };
    emit(carRent);
  }
}



/* 
  {
    "idCliente": "string",
    "idVehiculo": "string",
    "nombre": "string",
    "telefono": "string",
    "direccionOrigen": "string",
    "ciudadOrigen": "string",
    "ciudad_pickUp": "string",
    "fecha_pickUp": "string",
    "tiempo_picUp": "string",
    "ciudad_dropOff": "salamanca",
    "fecha_dropOff": "string",
    "tiempo_dropOff": "string"
}

 */