import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/pontosTuristicos.dart';
import 'filtro_page.dart';
import 'form_new_point.dart';

class ListaPontosTuristicos extends StatefulWidget {
  @override
  _ListaPontosTuristicos createState() => _ListaPontosTuristicos();

}

class _ListaPontosTuristicos extends State<ListaPontosTuristicos> {

  static const ACAO_EDITAR = 'editar';
  static const ACAO_EXCLUIR = 'excluir';
  static const ACAO_VISUALIZAR = 'visualizar';

  final pontosTuristicos = <PontoTuristico>[
    PontoTuristico(
        id: 1,
        descricao: 'Garden Club',
        inclusao: DateTime.now().add(Duration(days: 5)),
        diferencial: 'Casa de Show'
    )
  ];

  var _ultimoId = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _criarAppBar(),
      body: _criarBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: _abrirForm,
        tooltip: 'Novo Ponto',
        child: Icon(Icons.add),
      ),
    );
  }

  void _abrirForm({PontoTuristico? pontoTuristico, int? index, bool? readOnly}) {
    final key = GlobalKey<FormNewPointState>();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(pontoTuristico == null ? 'Novo Ponto' : 'Alterar o Ponto: ${pontoTuristico.id}'),
            content: FormNewPoint(key: key, pontoTuristico: pontoTuristico),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: readOnly == true ? Text('Voltar') : Text('Cancelar')
              ),
              if (readOnly == null || readOnly == false)
                TextButton(
                    onPressed: () {
                      if (key.currentState != null && key.currentState!.dadosValidados()) {
                        setState(() {
                          final novoPonto = key.currentState!.newPoint;
                          if (index == null) {
                            novoPonto.id = ++ _ultimoId;
                            pontosTuristicos.add(novoPonto);
                          } else {
                            pontosTuristicos[index] = novoPonto;
                          }
                        });
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('Salvar')
                )
            ],
          );
        }
    );
  }


  void _excluirTarefa(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
              children: [
                Icon(Icons.warning, color: Colors.red),
                Padding(
                    padding: EdgeInsets.only(left: 10),
                child: Text('Atenção'),
                )
              ],
            ),
            content: Text('Esse registro será deletado permanentemente'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(), child: Text('Cancelar')
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      pontosTuristicos.removeAt(index);
                    });
                  }, child: Text('Confirmar')
              ),
            ],
          );
        });
  }

  AppBar _criarAppBar() {
    return AppBar(
      title: const Text('Gerenciador de Pontos Turisticos'),
      actions: [
        IconButton(
            onPressed: _abrirPaginaFiltro,
            icon: const Icon(Icons.filter_list)),
      ],
    );
  }

  Widget _criarBody() {
    if (pontosTuristicos.isEmpty) {
      return const Center(
        child: Text('Não existe nenhum ponto cadastrado!',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      );
    }
    return ListView.separated(
      itemCount: pontosTuristicos.length,
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemBuilder: (BuildContext context, int index) {
        final pontoAtual = pontosTuristicos[index];

        return PopupMenuButton<String>(
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${pontoAtual.id} - ${pontoAtual.descricao}'),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Data de Inclusão - ${pontoAtual.dataInclusaoFormatado}'),
                Text('Diferenciais - ${pontoAtual.diferencial}'),
              ],
            )
          ),
          itemBuilder: (BuildContext context) => _criarItensMenu(),
          onSelected: (String valorSelecionado) {
            if (valorSelecionado == ACAO_EDITAR) {
              _abrirForm(pontoTuristico: pontoAtual, index: index, readOnly: false);
            } else if (valorSelecionado == ACAO_EXCLUIR) {
              _excluirTarefa(index);
            } else if (valorSelecionado == ACAO_VISUALIZAR) {
              _abrirForm(pontoTuristico: pontoAtual, index: index, readOnly: true);
            }
          },
        );
      },
    );
  }

  List<PopupMenuEntry<String>> _criarItensMenu() {
    return [
      PopupMenuItem(
          value: ACAO_VISUALIZAR,
          child: Row(
            children: [
              Icon(Icons.visibility, color: Colors.black,),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text('Visualizar'),
              )
            ],
          )
      ),
      PopupMenuItem(
        value: ACAO_EDITAR,
          child: Row(
            children: [
              Icon(Icons.edit, color: Colors.black,),
              Padding(
                  padding: EdgeInsets.only(left: 10),
                child: Text('Editar'),
              )
            ],
          )
      ),
      PopupMenuItem(
          value: ACAO_EXCLUIR,
          child: Row(
            children: [
              Icon(Icons.delete, color: Colors.red,),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text('Excluir'),
              )
            ],
          )
      )
    ];
  }

  void _abrirPaginaFiltro() {
    final navigator = Navigator.of(context);
    navigator.pushNamed(FiltroPage.routeName).then((alterouValores) {
      if (alterouValores == true) {
        ///TODO filtro
      }
    });
  }
}