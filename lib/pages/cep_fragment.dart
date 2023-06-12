import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../model/endereco.dart';
import '../services/cep_service.dart';

class CepFragment extends StatefulWidget{

  static const title = 'Consulta Cep';

  @override
  State<StatefulWidget> createState() => _CepFragmentState();

}

class _CepFragmentState extends State<CepFragment>{
  final _service = CepService();
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _cepFormater = MaskTextInputFormatter(
    mask: '#####-###',
    filter: {'#' : RegExp(r'[0-9]')}
  );

  var _loading = false;
  Endereco? _endereco;

  Widget build(BuildContext context){
    return Padding(
        padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Form(
            key: _formKey,
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'CEP',
                  suffixIcon: _loading ? const Padding(
                      padding: EdgeInsets.all(10),
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  ) : IconButton(
                      onPressed: _findCep,
                      icon: Icon(Icons.search)
                  ),
                ),
                inputFormatters: [_cepFormater],
                validator: (String? value){
                  if (value == null || value.isEmpty || !_cepFormater.isFill()){
                    return 'Informe um cep válido!';
                  }
                  return null;
                },
              ),
          ),
          Container(height: 10),
          ..._buildWidgets()
        ],
      ),
    );
  }

  Future<void> _findCep() async {
    if (_formKey.currentState == null || !_formKey.currentState!.validate()){
      return;
    }

    setState(() {
      _loading = true;
    });

    try{
      _endereco = await _service.findEnderecoAsObject(_cepFormater.getUnmaskedText());
    } catch (erro){
      debugPrint(erro.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Ocorreu o erro: ${erro.toString()} ')));
    }

    setState(() {
      _loading = false;
    });

  }

  List<Widget> _buildWidgets(){
    final List<Widget> widgets = [];

    if (_endereco != null){
      final map = _endereco!.toJson();

      for (final key in map.keys){
        widgets.add(Text('$key: ${map[key]}'));
      }
    }
    return widgets;
  }
}
