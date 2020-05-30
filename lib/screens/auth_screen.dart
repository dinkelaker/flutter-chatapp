import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;

  bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }

  void _submitAuthForm(String email, String username, String password,
      bool isLogin, BuildContext ctxt) async {
    AuthResult authResult;

    setState(() {
      _isLoading = true;
    });

    try {
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        await Firestore.instance
            .collection('users')
            .document(authResult.user.uid)
            .setData({
          'username': username,
          'email': email,
        });
        print('User created');
      }
    } on PlatformException catch (err) {
      var message = 'An error occurered.please check your credentials!';

      if (err.message != null) {
        message = err.message;
      }

      Scaffold.of(ctxt).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctxt).errorColor,
        ),
      );
    } catch (err) {
      print(err);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: AuthForm(_submitAuthForm, _isLoading));
  }
}
