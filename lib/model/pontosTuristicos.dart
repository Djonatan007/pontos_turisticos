import 'package:intl/intl.dart';

class PontoTuristico {
  static const CAMPO_ID = 'id';
  static const CAMPO_DESCRICAO = 'descricao';
  static const CAMPO_DIFERENCIAIS = 'diferencial';
  static const CAMPO_DATA_INCLUSAO = 'inclusão';

  int id;
  String descricao;
  String? diferencial;
  DateTime inclusao;

  PontoTuristico( { required this.id, required this.descricao, required this.inclusao, this.diferencial});

  String get dataInclusaoFormatado{
    if (inclusao == null) {
      return '';
    }

    return DateFormat('dd/MM/yyyy').format(inclusao!);
  }
}