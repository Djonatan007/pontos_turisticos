

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pontos_turisticos/model/pontosTuristicos.dart';

class DetalhePonto extends StatefulWidget {
  final PontoTuristico pontoTuristico;

  const DetalhePonto({Key? key, required this.pontoTuristico}):super(key: key);

  @override
  _DetalhePontoState createState() => _DetalhePontoState();

}

class _DetalhePontoState extends State<DetalhePonto> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Ponto ${widget.pontoTuristico.id}'),
      ),
      body: _criarBody(),

    );
  }

  Widget _criarBody() {
    return Padding(
        padding: EdgeInsets.all(10),
      child: ListView(
        children: [
          Row(
            children: [
              Campo(descricao: 'Código: '),
              Valor(valor: '${widget.pontoTuristico.id}')
            ],
          ),
          Row(
            children: [
              Campo(descricao: 'Nome: '),
              Valor(valor: '${widget.pontoTuristico.nome}')
            ],
          ),
          Row(
            children: [
              Campo(descricao: 'Descrição: '),
              Valor(valor: '${widget.pontoTuristico.descricao}')
            ],
          ),
          Row(
            children: [
              Campo(descricao: 'Diferencial: '),
              Valor(valor: '${widget.pontoTuristico.diferencial}')
            ],
          ),
          Row(
            children: [
              Campo(descricao: 'Data de Inclusão: '),
              Valor(valor: '${widget.pontoTuristico.dataInclusaoFormatado}')
            ],
          )
        ],
      ),
    );
  }
}

class Campo extends StatelessWidget{
  final String descricao;

  const Campo({Key? key, required this.descricao}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Expanded(
      flex: 1,
        child: Text(
          descricao,
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        )
    );
  }
}

class Valor extends StatelessWidget{
  final String valor;

  const Valor({Key? key, required this.valor}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Expanded(
        flex: 4,
        child: Text(
          valor,
        )
    );
  }
}


