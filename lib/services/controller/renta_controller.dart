import 'dart:convert';

import 'package:http/http.dart' as http;

class RentaController {
  Future<Map<String, dynamic>> getAllRentas() async {
    final url = Uri.parse('http://127.0.0.1:8888/rentas');
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

  Future<Map<String, dynamic>> postRenta(
      String idCliente,
      String idVehiculo,
      String nombre,
      String telefono,
      String direccion,
      String ciudad,
      String ciudadPickUp,
      String fechapickUp,
      String tiempoPicUp,
      String ciudadDropOff,
      String fechaDropOff,
      String tiempoDropOff) async {
    final url = Uri.parse('http://127.0.0.1:8888/rentas');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      "idCliente": idCliente,
      "idVehiculo": idVehiculo,
      "nombre": nombre,
      "telefono": telefono,
      "direccionOrigen": direccion,
      "ciudadOrigen": ciudad,
      "ciudad_pickUp": ciudadPickUp,
      "fecha_pickUp": fechapickUp,
      "tiempo_picUp": tiempoPicUp,
      "ciudad_dropOff": ciudadDropOff,
      "fecha_dropOff": fechaDropOff,
      "tiempo_dropOff": tiempoDropOff
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
}
