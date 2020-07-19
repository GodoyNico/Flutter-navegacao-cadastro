import 'package:flutter/material.dart';
import 'package:navegacao_cadastro/pages/register_page.dart';
import 'package:navegacao_cadastro/pages/user_list_page.dart';
import 'package:navegacao_cadastro/utils/app_rotas.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cadastro de Usuário',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        AppRotas.HOME_PAGE: (ctx) => UserListPage(),
        AppRotas.REGISTER_PAGE: (ctx) => RegisterPage(),
      },
    );
  }
}
