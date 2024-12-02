import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginController {
  static const url = 'http://127.0.0.1:8888/';

  Future<Map<String, dynamic>> login(
      BuildContext context, String nombre, String password) async {
    final url = Uri.parse('http://127.0.0.1:8888/auth');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'usuario': nombre, 'password': password});

    try {
      final response = await http.post(url, headers: headers, body: body);
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

  saveDataUser(Map<String, dynamic> data) {
    // BlocUserDataGlobal().setUserDataGlobal(data);
  }
}
