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
      "nome": "Robita bita",
      "idade": 89,
    };
    int id = await bd.insert("usuarios", dadosUsuario);
    print("Salvo: $id ");
  }

  _listarUsuarios() async {
    Database bd = await _recuperarBancodeDados();
    // String sql = "SELECT * FROM usuarios WHERE idade = 29 ";
    //String sql = "SELECT * FROM usuarios WHERE idade >= 29 AND idade <=46";
    //String sql = "SELECT * FROM usuarios WHERE idade BETWEEN 29 AND 46";
    //String sql = "SELECT * FROM usuarios WHERE idade IN (29,46)";
    //String sql = "SELECT * FROM usuarios WHERE nome LIKE 'Let%' ";
    //String sql = "SELECT * FROM usuarios WHERE nome LIKE '%tíci%' ";
    // String sql =
    // "SELECT * FROM usuarios WHERE 1=1 ORDER BY UPPER(nome) ASC "; // ascendente
    String sql =
        "SELECT * FROM usuarios WHERE 1=1 ORDER BY UPPER(nome) DESC "; //desc
    List usuarios = await bd.rawQuery(sql);
    //print('usuarios: ' + usuarios.toString());
    for (var usuario in usuarios) {
      print("item id: " +
          usuario['id'].toString() +
          " nome: " +
          usuario['nome'] +
          " idade: " +
          usuario['idade'].toString());
    }
  }

  //CRUD -> Create, Read, Update and Delete
  _recuperarUsuarioPeloId(int id) async {
    Database bd = await _recuperarBancodeDados();
    List usuarios = await bd.query(
      "usuarios",
      columns: ['id', 'nome', 'idade'],
      where: 'id = ?',
      whereArgs: [id],
    );
    for (var usuario in usuarios) {
      print("item id: " +
          usuario['id'].toString() +
          " nome: " +
          usuario['nome'] +
          " idade: " +
          usuario['idade'].toString());
    }
  }

  _excluirUsuario(int id) async {
    Database bd = await _recuperarBancodeDados();
    bd.delete(
      "usuarios",
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  _atualizarUsuario(int id) async {
    Database bd = await _recuperarBancodeDados();
    Map<String, dynamic> dadosUsuario = {
      "nome": "Pato pato bato",
      "idade": 2,
    };
    bd.update(
      'usuarios',
      dadosUsuario,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Widget build(BuildContext context) {
    // _salvar();
    //_listarUsuarios();
    //_recuperarUsuarioPeloId(1);
    //_excluirUsuario(3);
    // _atualizarUsuario(4);
    // _listarUsuarios();

    return Container();
  }
}
