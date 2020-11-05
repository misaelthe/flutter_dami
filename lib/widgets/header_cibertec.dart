import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeaderCibertecWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Image(
              image: AssetImage("assets/colegiologo.png"),
              width: 120,
              height: 20,
            )
          ],
        ),
        Column(
          children: [
            Text(
              'Instituto',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
            Text(
              'Cibertec',
              style: TextStyle(fontFamily: 'Raleway'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text('Direccion',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontFamily: 'Raleway')),
            ),
            Text('Av. Carlos Izaguirre 233',
                style: TextStyle(fontFamily: 'Raleway')),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text('Telefono',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontFamily: 'Raleway')),
            ),
            Text('633-5555', style: TextStyle(fontFamily: 'Raleway')),
          ],
        ),
      ],
    );
  }
}
