import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:navegacao_cadastro/entities/user.dart';
import 'package:navegacao_cadastro/utils/app_rotas.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _form = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _emailController = TextEditingController();
  User _user = User();
  bool _controller = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Cadastro de Usuário'),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRotas.HOME_PAGE);
            }),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                  labelStyle: TextStyle(color: Colors.teal),
                  labelText: 'Nome completo',
                ),
                validator: (value) {
                  if (value.length < 3) return 'O nome é muito curto';
                  if (value.length > 30) return 'O nome é muito longo';
                  return null;
                },
                onSaved: (newLog) {
                  _user.name = newLog;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                  labelStyle: TextStyle(color: Colors.teal),
                  labelText: 'Idade',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if ((int.tryParse(value) ?? 0) <= 0)
                    return 'A idade é inválida';
                  return null;
                },
                onSaved: (newLog) {
                  _user.age = int.tryParse(newLog);
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                  labelStyle: TextStyle(color: Colors.teal),
                  labelText: 'Email',
                ),
                validator: (value) {
                  final bool isValid = EmailValidator.validate(value);
                  if (!isValid) {
                    return 'Email inválido';
                  }
                  return null;
                },
                onSaved: (newLog) {
                  _user.email = newLog;
                },
              ),
              SizedBox(height: 10),
              Container(
                width: double.maxFinite,
                child: OutlineButton(
                  onPressed: () {
                    saveUser();
                    if (_controller) {
                      Navigator.of(context).pop(_user);
                    }
                  },
                  child: Text(
                    'Salvar',
                    style: TextStyle(fontSize: 20),
                  ),
                  textColor: Colors.teal,
                  borderSide: BorderSide(
                    color: Colors.teal,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void logValidate() {
    if (!_form.currentState.validate()) {
      _controller = false;
      _scaffoldKey.currentState
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
              duration: Duration(milliseconds: 2500),
              content: Text(
                'Dados inválidos',
                style: TextStyle(fontSize: 18),
              ),
              backgroundColor: Colors.red),
        );
      return;
    }
    _controller = true;
  }

  void saveUser() {
    _form.currentState.save();
    logValidate();
  }
}
