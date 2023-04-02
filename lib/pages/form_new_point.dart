import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/pontosTuristicos.dart';

class FormNewPoint extends StatefulWidget {
  final PontoTuristico? pontoTuristico;

  FormNewPoint({Key? key, this.pontoTuristico}) : super (key: key);

  @override
  FormNewPointState createState() => FormNewPointState();

}

class FormNewPointState extends State<FormNewPoint> {
  final formKey = GlobalKey<FormState>();
  final descricaoController = TextEditingController();
  final inclusaoController = TextEditingController();
  final diferenciaisController = TextEditingController();
  final _dateFormat = DateFormat('dd/MM/yyyy');
  bool podeEditar = false;

  @override
  void initState() {
    super.initState();

    if (widget.pontoTuristico != null) {
      descricaoController.text = widget.pontoTuristico!.descricao;
      inclusaoController.text = widget.pontoTuristico!.dataInclusaoFormatado;
      diferenciaisController.text = widget.pontoTuristico!.diferencial!;
      podeEditar = true;
    } else {
      inclusaoController.text = _dateFormat.format(DateTime.now());
    }
  }

  Widget build(BuildContext context){
    return Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: descricaoController,
              decoration: InputDecoration(labelText: 'Descrição'),
              validator: (String? valor) {
                if (valor == null || valor.isEmpty) {
                  return 'Informe a descrição';
                }
                return null;
              },
            ),
            TextFormField(
              controller: diferenciaisController,
              decoration: InputDecoration(labelText: 'Diferenciais'),
            ),
            TextFormField(
              controller: inclusaoController,
              decoration: InputDecoration(
                labelText: 'Data de Inclusão',
                prefixIcon: IconButton(
                  onPressed: () => {},
                  icon: Icon(Icons.calendar_today),
                )
              ),
              validator: (String? valor) {
                if (valor == null || valor.isEmpty) {
                  return 'Data de inclusão não pode ser vazia';
                }
                return null;
              },
              readOnly: true,
            ),
          ],
        ),
    );
  }

  bool dadosValidados() => formKey.currentState?.validate() == true;

  PontoTuristico get newPoint => PontoTuristico(
      id: widget.pontoTuristico?.id ?? 0,
      descricao: descricaoController.text,
      inclusao: _dateFormat.parse(inclusaoController.text),
      diferencial: diferenciaisController.text
  );
}