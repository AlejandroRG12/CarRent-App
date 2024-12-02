import 'package:bloc/bloc.dart';

class BlocUserDataGlobal extends Cubit<Map<String, dynamic>> {
  BlocUserDataGlobal()
      : super({
          'id': '',
          'nombre': '',
          'aPaterno': '',
          'aMaterno': '',
          'email': '',
          'direccion': '',
          'ciudad': '',
          'fechaNacimiento': '',
          'rol': '',
          'usuario': '',
        });

  void setUserDataGlobal(Map<String, dynamic> data) {
    final Map<String, dynamic> userData = {
      'id': data['id'],
      'nombre': data['nombre'],
      'aPaterno': data['aPaterno'],
      'aMaterno': data['aMaterno'],
      'email': data['email'],
      'direccion': data['direccion'],
      'ciudad': data['ciudad'],
      'fechaNacimiento': data['fechaNacimiento'],
      'rol': data['rol'],
      'usuario': data['usuario'],
    };
    emit(userData);
  }

  void resetUserDataGlobal() {
    final Map<String, dynamic> userData = {
      'id': '',
      'nombre': '',
      'aPaterno': '',
      'aMaterno': '',
      'email': '',
      'direccion': '',
      'ciudad': '',
      'fechaNacimiento': '',
      'rol': '',
      'usuario': '',
    };
    emit(userData);
  }
}

  /* 
    {aMaterno: Garcia, aPaterno: Ramirez, ciudad: Gto, direccion: Calle 12356145, email: garcia4312@hotmail.com, fechaNacimiento: 1999-02-08, id: null, nombre: Alejandro, password: $2b$12$5RLiTUjUGmu3jlH2JBX0EeRI0Dyj4hfl2/5q2Wl1RlahsI88Wu4se, rol: super admin, usuario: alejandro}

 */
