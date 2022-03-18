import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _recuperarBancodeDados() async {
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados = join(caminhoBancoDados, "banco.db");

    var bd = await openDatabase(
      localBancoDados,
      version: 1,
      onCreate: (db, dbVersaoRecente) {
        String sql =
            "CREATE TABLE usuarios (id INTEGER PRIMARY KEY AUTOINCREMENT, nome VARCHAR, idade INTEGER)";
        db.execute(sql);
      },
    );
    return bd;
    // print("aberto: " + retorno.isOpen.toString());
  }

  _salvar() async {
    Database bd = await _recuperarBancodeDados();
    Map<String, dynamic> dadosUsuario = {
      "nome": "Gaboel",
      "idade": 33,
    };
    int id = await bd.insert("usuarios", dadosUsuario);
    print("Salvo: $id ");
  }

  @override
  Widget build(BuildContext context) {
    _salvar();
    return Container();
  }
}
