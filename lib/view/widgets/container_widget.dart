import 'package:flutter/material.dart';

class ContainerWidget extends StatelessWidget {
  const ContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 10),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Anotações', //Titulo
                style: TextStyle(color: Colors.teal, fontSize: 20),
              ),
              Text(
                'Fazer isso aqui', //descrição ou linha mais recente
                style: TextStyle(fontSize: 12),
              ),
              Text(
                '16:20', //horario
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
