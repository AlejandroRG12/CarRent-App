import 'dart:math';

import 'package:flutter/material.dart';

Widget cardInfoCar(
    BuildContext context,
    String name,
    String descripcion,
    int starts,
    String typeCar,
    String capacity,
    String steering,
    String gasoline,
    String total) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
    // extender el tamaño del width en toda la pantalla
    width: MediaQuery.of(context).size.width * 0.6,

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
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(
            fontFamily: 'PlusBold',
            fontSize: 40,
          ),
        ),
        startsRating(starts),
        const SizedBox(height: 20),
        descriptionCar(descripcion),
        const SizedBox(height: 20),
        infoCar(typeCar, capacity, steering, gasoline, total),
      ],
    ),
  );
}

Widget infoCar(String typeCar, String capacity, String steering,
    String gasoline, String total) {
  return Row(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          infoCarRow('Tipo de coche:', typeCar),
          infoCarRow('Capacidad:', capacity),
        ],
      ),
      const SizedBox(width: 20),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          infoCarRow('Dirección:', steering),
          infoCarRow('Gasolina:', gasoline),
        ],
      ),
      const SizedBox(width: 40),
      // total de la renta
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            'Total:',
            style: TextStyle(
              fontFamily: 'PlusLight',
              fontSize: 18,
              color: Color(0xff90A3BF),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            '\$ $total',
            style: const TextStyle(
              fontFamily: 'PlusBold',
              fontSize: 18,
              color: Color(0xff3563E9),
            ),
          ),
        ],
      ),
    ],
  );
}

Widget infoCarRow(String title, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: const TextStyle(
          fontFamily: 'PlusLight',
          fontSize: 18,
          color: Color(0xff90A3BF),
        ),
      ),
      const SizedBox(width: 10),
      Text(
        value,
        style: const TextStyle(
          fontFamily: 'PlusBold',
          fontSize: 18,
          color: Color(0xff596780),
        ),
      ),
    ],
  );
}

Widget descriptionCar(String description) {
  return Container(
    margin: const EdgeInsets.only(top: 20),
    child: Text(
      description,
      style: const TextStyle(
        fontFamily: 'PlusRegular',
        fontSize: 18,
        color: Color(0xff90A3BF),
      ),
    ),
  );
}

Widget startsRating(int starts) {
  final limitedStarts = max(0, min(starts, 5));
  return Row(
    children: List.generate(
      5,
      (index) => Icon(
        index < limitedStarts ? Icons.star : Icons.star_border,
        color: Colors.amber,
      ),
    ),
  );
}

Widget cardImages(String urlPincipalImage, String titulo, String modelo) {
  return SizedBox(
    width: 500,
    child: Column(
      children: [
        Container(
          height: 400,
          width: 500,
          margin: const EdgeInsets.all(0),
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          decoration: BoxDecoration(
            color: const Color(0xff3563E9),
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                offset: Offset(0, 5),
              ),
            ],
            image:
                const DecorationImage(image: AssetImage('assets/img/rows.png')),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'El coche perfecto para cada camino: diseño, potencia y confort en uno solo.',
                style: TextStyle(
                  fontFamily: 'PlusBold',
                  fontSize: 20,
                  color: Colors.white,
                  //separar las palabras
                  wordSpacing: 5,
                  letterSpacing: 1,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Seguridad y comodidad al conducir un coche deportivo futurista y elegante.',
                style: TextStyle(
                  fontFamily: 'PlusRegular',
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
              Image(
                image: AssetImage('assets/img/nissanGTR.png'),
                //Centrar la imagen
                alignment: Alignment.center,
                height: 250,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            showSmallImage(urlPincipalImage),
            showSmallImage(urlPincipalImage),
            showSmallImage(urlPincipalImage),
          ],
        )
      ],
    ),
  );
}

Widget showSmallImage(String? url) {
  return Container(
    height: 100,
    width: 160,
    margin: const EdgeInsets.all(0),
    decoration: BoxDecoration(
      color: const Color(0xff3563E9),
      borderRadius: BorderRadius.circular(15),
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 5,
          offset: Offset(0, 5),
        ),
      ],
    ),
    child: Image(
      image: AssetImage(url ?? 'assets/img/no-image.png'),
    ),
  );
}
