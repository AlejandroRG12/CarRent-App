import 'dart:convert';

import 'package:http/http.dart' as http;

class CarsController {
  static const url = 'http://127.0.0.1:8888/';

  Future<Map<String, dynamic>> getAllVehiculos() async {
    final url = Uri.parse('http://127.0.0.1:8888/vehiculos');
    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['code'] == 200) {
          //print(responseData['data']);
          // La solicitud fue exitosa y el usuario fue autenticado
          return responseData;
        } else {
          // La solicitud fue exitosa pero hubo un error en la autenticación
          return {'error': responseData['message']};
        }
      } else {
        // La solicitud falló
        return {'error': 'Error en la solicitud: ${response.statusCode}'};
      }
    } catch (e) {
      // Hubo un error en la solicitud
      return {'error': 'Error haciendo la solicitud: $e'};
    }
  }

  Future<Map<String, dynamic>> getVehiculoById(String id) async {
    final url = Uri.parse('http://127.0.0.1:8888/vehiculos/$id');
    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['code'] == 200) {
          // La solicitud fue exitosa y el usuario fue autenticado
          return responseData;
        } else {
          // La solicitud fue exitosa pero hubo un error en la autenticación
          return {'error': responseData['message']};
        }
      } else {
        // La solicitud falló
        return {'error': 'Error en la solicitud: ${response.statusCode}'};
      }
    } catch (e) {
      // Hubo un error en la solicitud
      return {'error': 'Error haciendo la solicitud: $e'};
    }
  }

  Future<Map<String, dynamic>> addVehiculo(
    String nombre,
    String modelo,
    String marca,
    List<String> imgs,
    String tamanioTanque,
    String tipoDeTransmision,
    String capacidad,
    String precioPorRenta,
    String descripcion,
  ) async {
    final url = Uri.parse('http://127.0.0.1:8888/vehiculos');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      "nombre": nombre,
      "modelo": modelo,
      "marca": marca,
      "imgs": imgs,
      "tamanioTanque": tamanioTanque,
      "tipoDeTransmision": tipoDeTransmision,
      "capacidad": capacidad,
      "precioPorRenta": precioPorRenta,
      "descripcion": descripcion
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        if (responseData['code'] == 201) {
          // La solicitud fue exitosa y el usuario fue autenticado
          return responseData;
        } else {
          // La solicitud fue exitosa pero hubo un error en la autenticación
          return {'error': responseData['message']};
        }
      } else {
        // La solicitud falló
        return {'error': 'Error en la solicitud: ${response.statusCode}'};
      }
    } catch (e) {
      // Hubo un error en la solicitud
      return {'error': 'Error haciendo la solicitud: $e'};
    }
  }

  Future<Map<String, dynamic>> updateVehiculo(
    String id,
    String nombre,
    String modelo,
    String marca,
    List<String> imgs,
    String tamanioTanque,
    String tipoDeTransmision,
    String capacidad,
    String precioPorRenta,
    String descripcion,
  ) async {
    final url = Uri.parse('http://127.0.0.1:8888/vehiculos/$id');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      "nombre": nombre,
      "modelo": modelo,
      "marca": marca,
      "imgs": imgs,
      "tamanioTanque": tamanioTanque,
      "tipoDeTransmision": tipoDeTransmision,
      "capacidad": capacidad,
      "precioPorRenta": precioPorRenta,
      "descripcion": descripcion
    });

    try {
      final response = await http.put(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['code'] == 200) {
          // La solicitud fue exitosa y el usuario fue autenticado
          return responseData;
        } else {
          // La solicitud fue exitosa pero hubo un error en la autenticación
          return {'error': responseData['message']};
        }
      } else {
        // La solicitud falló
        return {'error': 'Error en la solicitud: ${response.statusCode}'};
      }
    } catch (e) {
      // Hubo un error en la solicitud
      return {'error': 'Error haciendo la solicitud: $e'};
    }
  }

  Future<Map<String, dynamic>> deleteVehiculo(String id) async {
    final url = Uri.parse('http://127.0.0.1:8888/vehiculos/$id');
    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.delete(url, headers: headers);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['code'] == 200) {
          // La solicitud fue exitosa y el usuario fue autenticado
          return responseData;
        } else {
          // La solicitud fue exitosa pero hubo un error en la autenticación
          return {'error': responseData['message']};
        }
      } else {
        // La solicitud falló
        return {'error': 'Error en la solicitud: ${response.statusCode}'};
      }
    } catch (e) {
      // Hubo un error en la solicitud
      return {'error': 'Error haciendo la solicitud: $e'};
    }
  }
}
