import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/pontosTuristicos.dart';

class FiltroPage extends StatefulWidget {
  static const routeName = '/filtro';
  static const chaveCampoOrdenacao = 'campoOrdenacao';
  static const chaveUsarOrdemDesc = 'usarOrdemDecrescente';
  static const chaveCampoDescricao = 'campoDescricao';
  static const chaveCampoDiferenciais = 'campoDiferenciais';

  @override
  _FiltroPageState createState() => _FiltroPageState();

}

class _FiltroPageState extends State<FiltroPage> {

  final _camposParaOrdenacao = {
    PontoTuristico.CAMPO_ID: 'Código',
    PontoTuristico.CAMPO_DESCRICAO: 'Descrição',
    PontoTuristico.CAMPO_DATA_INCLUSAO: 'Data de Inclusão',
    PontoTuristico.CAMPO_DIFERENCIAIS: 'Diferenciais'
  };

  late final SharedPreferences _prefs;
  final _descricaoController = TextEditingController();
  final _diferenciaisController = TextEditingController();
  String _campoOrdenacao = PontoTuristico.CAMPO_ID;
  bool _usarOrdemDecrescente = false;
  bool _alterouValores = false;

  @override
  void initState(){
    super.initState();
    _carregaDadosSharedPreferences();
  }

  void _carregaDadosSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();

    setState(() {
      _campoOrdenacao = _prefs.getString(FiltroPage.chaveCampoOrdenacao) ?? PontoTuristico.CAMPO_ID;
      _usarOrdemDecrescente = _prefs.getBool(FiltroPage.chaveUsarOrdemDesc) == true;
      _descricaoController.text = _prefs.getString(FiltroPage.chaveCampoDescricao) ?? '';
      _diferenciaisController.text = _prefs.getString(FiltroPage.chaveCampoDiferenciais) ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Filtro e Ordenação'),
          ),
          body: _criarBody(),
        ),
        onWillPop: _onVoltarClick
    );
  }


  Widget _criarBody() {
    return ListView(
      children: [
          Padding(
              padding: EdgeInsets.only(left: 10,top: 10),
            child: Text('Campos de Ordenação'),
          ),
        for (final campo in _camposParaOrdenacao.keys)
          Row(
            children: [
              Radio(
                  value: campo,
                  groupValue: _campoOrdenacao,
                  onChanged: _onCampoParaOrdenacaoChanged,
              ),
              Text(_camposParaOrdenacao[campo]!),
            ],
          ),
        Divider(),
        Row(
          children: [
            Checkbox(
                value: _usarOrdemDecrescente,
                onChanged: _onUsarOrdemDecrescente
            ),
            Text('Usar ordem decrescente')
          ],
        ),
        Divider(),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Descrição começa com:'
            ),
            controller: _descricaoController,
            onChanged: _onFiltroDescricaoChanged,
          ),
        ),
        Divider(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            decoration: InputDecoration(
                labelText: 'Diferenciais contém:'
            ),
            controller: _diferenciaisController,
            onChanged: _onFiltroDiferenciaisChanged,
          ),
        ),
      ],
    );
  }

  void _onCampoParaOrdenacaoChanged(String? valor) {
    _prefs.setString(FiltroPage.chaveCampoOrdenacao, valor!);
    _alterouValores = true;
    setState(() {
      _campoOrdenacao = valor;
    });
  }

  void _onUsarOrdemDecrescente(bool? valor) {
    _prefs.setBool(FiltroPage.chaveUsarOrdemDesc, valor!);
    _alterouValores = true;
    setState(() {
      _usarOrdemDecrescente = valor;
    });
  }

  void _onFiltroDescricaoChanged(String? valor) {
    _prefs.setString(FiltroPage.chaveCampoDescricao, valor!);
    _alterouValores = true;
  }

  void _onFiltroDiferenciaisChanged(String? valor) {
    _prefs.setString(FiltroPage.chaveCampoDiferenciais, valor!);
    _alterouValores = true;
  }

  Future<bool> _onVoltarClick() async {
    Navigator.of(context).pop(_alterouValores);
    return true;
  }
}