import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget cardCar({
  required BuildContext context,
  required String name,
  required model,
  required brand,
  required sizeTank,
  required transmissionType,
  required capacity,
  required pricePerRent,
  required description,
  String? imgUrl,
  bool? activeMargin = false,
  double? margin = 0,
  void Function()? onTap,
}) {
  return Container(
    height: 390,
    width: 300,
    margin: activeMargin == true
        ? EdgeInsets.only(right: margin ?? 0, bottom: margin ?? 0)
        : const EdgeInsets.all(0),
    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
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
        Text(
          name,
          style: const TextStyle(fontFamily: 'PlusBold', fontSize: 20),
        ),
        Text(
          model,
          style: const TextStyle(
              fontFamily: 'PlusBold', fontSize: 12, color: Color(0xff90A3BF)),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: ShaderMask(
            shaderCallback: (bounds) {
              return LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.transparent,
                  Colors.white.withOpacity(1),
                ],
                stops: const [0.0, 0.5],
              ).createShader(bounds);
            },
            blendMode: BlendMode.dstIn,
            child: Image(
              image: AssetImage(imgUrl ?? 'assets/img/nissanGTR.png'),
              fit: BoxFit.contain,
              height: 140,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/gasIcon.svg',
              height: 20,
            ),
            const SizedBox(width: 5),
            Text(
              sizeTank,
              style: const TextStyle(
                  fontFamily: 'PlusBold',
                  fontSize: 12,
                  color: Color(0xff90A3BF)),
            ),
            const SizedBox(width: 10),
            SvgPicture.asset(
              'assets/icons/transmintionIcon.svg',
              height: 20,
            ),
            const SizedBox(width: 5),
            Text(
              transmissionType,
              style: const TextStyle(
                  fontFamily: 'PlusBold',
                  fontSize: 12,
                  color: Color(0xff90A3BF)),
            ),
            const SizedBox(width: 10),
            SvgPicture.asset(
              'assets/icons/peopleIcon.svg',
              height: 20,
            ),
            const SizedBox(width: 5),
            Text(
              capacity,
              style: const TextStyle(
                  fontFamily: 'PlusBold',
                  fontSize: 12,
                  color: Color(0xff90A3BF)),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Text(
                  '\$$pricePerRent/',
                  style: const TextStyle(
                      fontFamily: 'PlusBold',
                      fontSize: 20,
                      color: Colors.black),
                ),
                const Text(
                  'dia',
                  style: TextStyle(
                      fontFamily: 'PlusBold',
                      fontSize: 12,
                      color: Color(0xff90A3BF)),
                ),
              ],
            ),
            InkWell(
              onTap: onTap,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xff3563E9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Rentar',
                  style: TextStyle(
                      fontFamily: 'PlusBold',
                      fontSize: 12,
                      color: Colors.white),
                ),
              ),
            )
          ],
        )
      ],
    ),
  );
}


/* 
        self.nombre = nombre
        self.modelo = modelo
        self.marca = marca
        self.imgs = imgs if imgs is not None else []  # Asegúrate de que imgs sea una lista
        self.tamanioTanque = tamanioTanque
        self.tipoDeTransmision = tipoDeTransmision
        self.capacidad = capacidad
        self.precioPorRenta = precioPorRenta
        self.descripcion = descripcion
 */