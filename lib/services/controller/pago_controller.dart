import 'dart:convert';

import 'package:http/http.dart' as http;

class PagoController {
  /* 
  id
  id_renta
  targeta_numero
  targeta_expiracion
  targeta_propietario
  targeta_cvc
  montoTotal
  fecha
 */

  Future<Map<String, dynamic>> postPago(
      String idRenta,
      String targetaNumero,
      String targetaExpiracion,
      String targetaPropietario,
      String targetaCvc,
      String montoTotal,
      String fecha) async {
    final url = Uri.parse('http://127.0.0.1:8888/pagos');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      "id_renta": idRenta,
      "targeta_numero": targetaNumero,
      "targeta_expiracion": targetaExpiracion,
      "targeta_propietario": targetaPropietario,
      "targeta_cvc": targetaCvc,
      "montoTotal": montoTotal,
      "fecha": fecha
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
