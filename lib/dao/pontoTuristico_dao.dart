
import 'package:pontos_turisticos/model/pontosTuristicos.dart';

import '../database/database_provider.dart';

class PontoTuristicoDao{

  final dbProvider = DataBaseProvider.instance;

  Future<bool> salvar (PontoTuristico ponto) async{
    final db = await dbProvider.database;
    final valores = ponto.toMap();

    if (ponto.id == null){
      ponto.id = await db.insert(PontoTuristico.NAME_TABLE, valores);
      return true;
    } else {
      final registrosAtualizados = await db.update(PontoTuristico.NAME_TABLE, valores,
      where: '${PontoTuristico.CAMPO_ID} = ?', whereArgs: [ponto.id]);
      return registrosAtualizados > 0;
    }
  }

  Future<bool> deletar(ponto) async{
    final db = await dbProvider.database;
    final registrosAtualizados = await db.delete(PontoTuristico.NAME_TABLE,
    where: '${PontoTuristico.CAMPO_ID} = ?', whereArgs: [ponto.id]);
    return registrosAtualizados > 0;
  }

  Future<List<PontoTuristico>> listar({
    String filtroDescricao = '',
    String campoOrdenacao = PontoTuristico.CAMPO_ID,
    String filtroDiferenciais = '',
    bool usarOrdemDecrescente = false
  }) async{
    String? where;
    var orderBy = campoOrdenacao;

    if (filtroDescricao.isNotEmpty){
      where = "UPPER(${PontoTuristico.CAMPO_DESCRICAO}) LIKE '${filtroDescricao.toUpperCase()}%'";
    }

    if (filtroDiferenciais.isNotEmpty){
      where = "UPPER(${PontoTuristico.CAMPO_DIFERENCIAIS}) LIKE '${filtroDiferenciais.toUpperCase()}%'";
    }

    if (usarOrdemDecrescente){
      orderBy += ' DESC';
    }

    final db = await dbProvider.database;
    final resultadoConsulta = await db.query(
        PontoTuristico.NAME_TABLE,
        columns: [
          PontoTuristico.CAMPO_ID,
          PontoTuristico.CAMPO_NOME,
          PontoTuristico.CAMPO_DESCRICAO,
          PontoTuristico.CAMPO_DIFERENCIAIS,
          PontoTuristico.CAMPO_DATA_INCLUSAO,
          PontoTuristico.CAMPO_FINALIZADO,
          PontoTuristico.CAMPO_LATITUDE,
          PontoTuristico.CAMPO_LONGITUDE,
          PontoTuristico.CAMPO_CEP
        ],
      where: where,
      orderBy: orderBy
    );

    return resultadoConsulta.map((m) => PontoTuristico.fromMap(m)).toList();
  }
}