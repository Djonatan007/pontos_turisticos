import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../dao/pontoTuristico_dao.dart';
import '../model/pontosTuristicos.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class FormNewPoint extends StatefulWidget {
  final PontoTuristico? pontoTuristico;

  FormNewPoint({Key? key, this.pontoTuristico}) : super (key: key);

  @override
  FormNewPointState createState() => FormNewPointState();

}

class FormNewPointState extends State<FormNewPoint> {
  final formKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final descricaoController = TextEditingController();
  final inclusaoController = TextEditingController();
  final diferenciaisController = TextEditingController();
  final cepController = TextEditingController();
  final _dateFormat = DateFormat('dd/MM/yyyy');
  MaskTextInputFormatter cepFormatter = MaskTextInputFormatter(mask: '#####-###');

  @override
  void initState() {
    super.initState();

    if (widget.pontoTuristico != null) {
      nomeController.text = widget.pontoTuristico!.nome;
      descricaoController.text = widget.pontoTuristico!.descricao;
      inclusaoController.text = widget.pontoTuristico!.dataInclusaoFormatado;
      diferenciaisController.text = widget.pontoTuristico!.diferencial!;
      cepController.text = widget.pontoTuristico!.cep;
    } else {
      inclusaoController.text = _dateFormat.format(DateTime.now());
    }
  }


  Widget build(BuildContext context){
    return Form(
        key: formKey,
        child:
        SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (String? valor) {
                  if (valor == null || valor.isEmpty) {
                    return 'Informe o Nome';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: descricaoController,
                decoration: const InputDecoration(labelText: 'Descrição'),
                validator: (String? valor) {
                  if (valor == null || valor.isEmpty) {
                    return 'Informe a descrição';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: diferenciaisController,
                decoration: const InputDecoration(labelText: 'Diferenciais'),
                validator: (String? valor) {
                  if (valor == null || valor.isEmpty) {
                    return 'Informe os disferenciais';
                  }
                  return null;
                },
              ),
              TextFormField(
                inputFormatters: [cepFormatter],
                controller: cepController,
                maxLength: 9,
                decoration: const InputDecoration(labelText: 'CEP'),
                validator: (String? valor) {
                  if (valor == null || valor.isEmpty) {
                    return 'Informe o CEP';
                  }
                  return null;
                },
              ),
              Divider(color: Colors.white,),
              Row(
                children: [
                  Icon(Icons.calendar_today),
                  Text("Inclusão: ${inclusaoController.text.isEmpty ? _dateFormat.format(DateTime.now()) : inclusaoController.text}")
                ],
              ),
            ],
          ),
        )

    );
  }

  bool dadosValidados() => formKey.currentState?.validate() == true;

  PontoTuristico get newPoint =>  PontoTuristico(
        id: widget.pontoTuristico?.id,
        nome: nomeController.text,
        descricao: descricaoController.text,
        inclusao: _dateFormat.parse(inclusaoController.text),
        diferencial: diferenciaisController.text,
        latitude: '',
        longitude: '',
        cep: cepController.text
  );
}