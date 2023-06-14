import 'package:intl/intl.dart';

class PontoTuristico {
  static const CAMPO_ID = 'id';
  static const CAMPO_NOME = 'nome';
  static const CAMPO_DESCRICAO = 'descricao';
  static const CAMPO_DIFERENCIAIS = 'diferencial';
  static const CAMPO_DATA_INCLUSAO = 'inclusão';
  static const CAMPO_FINALIZADO = 'finalizado';
  static const NAME_TABLE = 'pontos';
  static const CAMPO_LATITUDE = 'latitude';
  static const CAMPO_LONGITUDE = 'longitude';
  static const CAMPO_CEP = 'cep';

  int? id;
  String nome;
  String descricao;
  String? diferencial;
  DateTime inclusao;
  bool finalizado;
  String latitude;
  String longitude;
  String cep;

  PontoTuristico( { this.id, required this.nome, required this.descricao, required this.inclusao, this.diferencial,this.finalizado =false, required this.latitude,
    required this.longitude, required this.cep});

  String get dataInclusaoFormatado{
    if (inclusao == null) {
      return '';
    }

    return DateFormat('dd/MM/yyyy').format(inclusao!);
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
    CAMPO_ID: id,
    CAMPO_NOME: nome,
    CAMPO_DESCRICAO: descricao,
    CAMPO_DIFERENCIAIS: diferencial,
    CAMPO_DATA_INCLUSAO: inclusao == null ? null : DateFormat("yyyy-MM-dd").format(inclusao!),
    CAMPO_FINALIZADO: finalizado,
    CAMPO_LATITUDE: latitude,
    CAMPO_LONGITUDE: longitude,
    CAMPO_CEP: cep
  };

  factory PontoTuristico.fromMap(Map<String, dynamic> map) => PontoTuristico(
      id: map[CAMPO_ID] is int ? map[CAMPO_ID] : null,
      nome: map[CAMPO_NOME] is String ? map[CAMPO_NOME] : '',
      descricao: map[CAMPO_DESCRICAO] is String ? map[CAMPO_DESCRICAO] : '',
      diferencial: map[CAMPO_DIFERENCIAIS] is String ? map[CAMPO_DIFERENCIAIS] : '',
      inclusao: map[CAMPO_DATA_INCLUSAO] is DateTime ? DateFormat("yyyy-MM-dd").parse(map[CAMPO_DATA_INCLUSAO]) : DateTime.now(),
      finalizado: map[CAMPO_FINALIZADO] is bool ? map[CAMPO_FINALIZADO] : false,
      latitude: map[CAMPO_LATITUDE] is String ? map[CAMPO_LATITUDE] : '',
      longitude: map[CAMPO_LONGITUDE] is String ? map[CAMPO_LONGITUDE] : '',
      cep: map[CAMPO_CEP] is String ? map [CAMPO_CEP] : ''
  );

}