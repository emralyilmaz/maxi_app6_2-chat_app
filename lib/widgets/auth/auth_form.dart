import 'dart:io';

import 'package:flutter/material.dart';
import 'package:maxi_app6_2_shop_app/widgets/pickers/user_image_picker.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn, this.isLoading);

  final bool isLoading;
  final void Function(
    String email,
    String password,
    String userName,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = "";
  var _userName = "";
  var _userPassword = "";
  File _userImageFile;

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  void _trySumbit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    // FocusScope: formu gönderir göndermez hala açık olabilecek yazılım klavyesini kapatır,
    if (_userImageFile == null && !_isLogin) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Please pick an image"),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return;
    }

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(_userEmail.trim(), _userPassword.trim(), _userName.trim(),
          _isLogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
      margin: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!_isLogin) UserImagePicker(_pickedImage),
                TextFormField(
                  key: ValueKey("email"),
                  validator: (value) {
                    if (value.isEmpty ||
                        !value.contains("@") ||
                        !value.contains(".com")) {
                      return "Please enter a valid email address";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: "Email address"),
                  onSaved: (value) {
                    _userEmail = value;
                  },
                ),
                if (!_isLogin)
                  TextFormField(
                    key: ValueKey("username"),
                    validator: (value) {
                      if (value.isEmpty || value.length < 2) {
                        return "Please enter at least 2 characters.";
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: "Username"),
                    onSaved: (value) {
                      _userName = value;
                    },
                  ),
                TextFormField(
                  key: ValueKey("password"),
                  validator: (value) {
                    if (value.isEmpty || value.length < 6) {
                      return "Password must be at least 6 characters long.";
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: "Password"),
                  obscureText: true,
                  onSaved: (value) {
                    _userPassword = value;
                  },
                ),
                SizedBox(height: 12),
                if (widget.isLoading) CircularProgressIndicator(),
                if (!widget.isLoading)
                  RaisedButton(
                    onPressed: _trySumbit,
                    child: Text(_isLogin ? "Login" : "Signup"),
                  ),
                if (!widget.isLoading)
                  FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(_isLogin
                          ? "Creat new account"
                          : "I already have an account"))
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
