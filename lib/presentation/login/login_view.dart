import 'package:animate_do/animate_do.dart';
import 'package:carrentapp/core/core.dart';
import 'package:carrentapp/data/providers/bloc_user_data_global.dart';
import 'package:carrentapp/routes/routes.dart';
import 'package:carrentapp/services/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              padding: const EdgeInsets.all(100),
              child: Column(
                children: [
                  const Image(
                    image: AssetImage('assets/img/logoMoret.png'),
                    //covertura
                    fit: BoxFit.contain,
                    height: 30, // Mueve el parámetro width aquí
                  ),
                  const SizedBox(height: 50),
                  const Text('Bienvenido', style: TextStyle(fontSize: 30)),
                  const SizedBox(height: 10),
                  const Text('Ingresa tus credenciales para continuar',
                      style: TextStyle(fontSize: 18)),
                  const SizedBox(height: 50),
                  inputFieldWidget(
                    labelText: 'Email',
                    colorText: Colors.black,
                    icon: Icons.email_rounded,
                    textType: TextInputType.text,
                    controller: emailController,
                    obscureText: false,
                  ),
                  const SizedBox(height: 20),
                  inputFieldWidget(
                    labelText: 'Password',
                    colorText: Colors.black,
                    icon: Icons.lock,
                    textType: TextInputType.text,
                    controller: passwordController,
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  butonLogin(),
                ],
              ),
            ),
            const Spacer(),
            const LatteralBanner(),
          ],
        ),
      )),
    );
  }

  InkWell butonLogin() {
    return InkWell(
      onTap: () async {
        //UsuariosControler().getUsuarios();
        final res = await LoginController().login(
          context,
          emailController.text,
          passwordController.text,
        );
        if (res['error'] != null) {
          notification('Usuario o contraseña invalidos', Colors.red);
        } else {
          notification('Bienvenido', Colors.green);
          saveDataUser(res['data']);
          goHome();
        }
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text(
          'Iniciar Sesión',
          style: TextStyle(color: Colors.white, fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  notification(String message, Color color) {
    return notificationPop(context, message, color);
  }

  goHome() {
    context.go(Routes.home);
  }

  saveDataUser(Map<String, dynamic> data) {
    final userDataCubic = context.read<BlocUserDataGlobal>();
    userDataCubic.setUserDataGlobal(data);
  }
}

class LatteralBanner extends StatefulWidget {
  const LatteralBanner({
    super.key,
  });

  @override
  State<LatteralBanner> createState() => _LatteralBannerState();
}

class _LatteralBannerState extends State<LatteralBanner> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(100),
      decoration: const BoxDecoration(
        color: Colors.blue,
        /* borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ), */
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(78, 0, 0, 0),
            blurRadius: 10,
            spreadRadius: 1,
            offset: Offset(0, 0),
          ),
        ],
        /* image: DecorationImage(
          image: AssetImage('assets/img/BG.png'),
          fit: BoxFit.contain,
        ), */
      ),
      child: Expanded(
        child: FadeInLeft(
          duration: const Duration(milliseconds: 1500),
          child: const Image(
            image: AssetImage('assets/img/nissanGTR.png'),
          ),
        ),
      ),
    );
  }
}
