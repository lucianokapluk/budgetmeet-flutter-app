import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      color: Colors.deepPurple,
    );
  }
}

class HeaderCircular extends StatelessWidget {
  const HeaderCircular({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50.0),
              bottomRight: Radius.circular(50.0))),
    );
  }
}

class HeaderDiagonal extends StatelessWidget {
  const HeaderDiagonal({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: CustomPaint(
        painter: _HeaderDiagonalPainter(),
      ),
    );
  }
}

class _HeaderDiagonalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final lapiz = Paint();
    //propiedades
    lapiz.color = Colors.deepPurple; //color lapiuz
    lapiz.style = PaintingStyle.fill; // linea
    lapiz.strokeWidth = 5.0; //grosor lapiz

    final path = new Path();
    //DIBUJAR CON EL PATH Y EL LAPIZ
    path.lineTo(0, size.height * 0.20);
    path.lineTo(size.width * 0.50, size.height * 0.28);
    path.lineTo(size.width, size.height * 0.20);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    /*    path.lineTo(0, size.height * 0.5); */

    canvas.drawPath(path, lapiz);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class HeaderCurvo extends StatelessWidget {
  const HeaderCurvo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        painter: _HeaderCurvoPainter(),
      ),
    );
  }
}

class _HeaderCurvoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final lapiz = Paint();
    //propiedades
    lapiz.color = Colors.deepPurple[200]; //color lapiuz

    lapiz.style = PaintingStyle.fill; // linea
    lapiz.strokeWidth = 5.0; //grosor lapiz

    final path = new Path();
    //DIBUJAR CON EL PATH Y EL LAPIZ

    path.lineTo(0, size.height * 0.75);

    //curvaaa

    path.quadraticBezierTo(
      size.width * 0.20,
      size.height * 0.60,
      size.width * 0.5,
      size.height * 0.75,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.90,
      size.width,
      size.height * 0.75,
    );

    path.lineTo(size.width, 0);

    canvas.drawPath(path, lapiz);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
