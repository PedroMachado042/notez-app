import 'package:flutter/material.dart';

class NotePage extends StatelessWidget {
  const NotePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerTitle = TextEditingController();
    TextEditingController controllerTxt = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: controllerTitle,
                style: TextStyle(fontSize: 30),
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.white),
                  hintText: 'Título',
                  border: InputBorder.none,
                ),
              ),
              Divider(height: 30),
              TextField(
                //Corpo do texto
                controller: controllerTxt,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                style: TextStyle(height: 2.5, fontSize: 17),
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.white),
                  hintText:
                      'Escreva suas notas aqui',
                  border: InputBorder.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
