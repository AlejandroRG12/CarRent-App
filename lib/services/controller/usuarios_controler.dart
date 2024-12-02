import 'dart:convert';

import 'package:http/http.dart' as http;

class UsuariosControler {
  Future<void> getUsuarios() async {
    final url = Uri.parse('http://127.0.0.1:8888/usuarios');
    final headers = {'Content-Type': 'application/json'};
    print('se ejecuto la funcion');
    try {
      print('se ejecuto la funcion 2');
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('Datos del usuario: ${responseData['data']}');
        if (responseData['code'] == 200) {
          // La solicitud fue exitosa y el usuario fue autenticado
        } else {
          print('Error en la respuesta: ${responseData['message']}');
        }
      } else {
        print('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      print('Error haciendo la solicitud: $e');
    }
  }
}
