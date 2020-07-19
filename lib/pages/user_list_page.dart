import 'package:flutter/material.dart';
import 'package:navegacao_cadastro/data/data.dart';
import 'package:navegacao_cadastro/entities/user.dart';
import 'package:navegacao_cadastro/utils/app_rotas.dart';

class UserListPage extends StatefulWidget {
  @override
  _UserListPage createState() => _UserListPage();
}

class _UserListPage extends State<UserListPage> {
  var users = userList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Usuários cadastrados'),
        centerTitle: true,
        leading: Icon(Icons.home),
      ),
      body: ListView(
        children: users.map((user) {
          return ListTile(
            leading: Icon(Icons.person),
            title: Text('${user.name}, ${user.age}'),
            subtitle: Text(user.email),
            onLongPress: () {
              setState(() {
                users.remove(user);
              });
            },
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var user =
              await Navigator.of(context).pushNamed(AppRotas.REGISTER_PAGE);
          setState(() {
            users.add(user as User);
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
