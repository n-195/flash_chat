import 'package:flash_chat/components/action_button.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});
  static const String id = '/registration_screen';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool _showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: kFieldTextDecoration.copyWith(
                    hintText: 'Enter your email.'),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: kFieldTextDecoration.copyWith(
                    hintText: 'Enter your password.'),
              ),
              const SizedBox(
                height: 24.0,
              ),
              ActionButton(
                  colour: Colors.blueAccent,
                  onPressedAction: () async {
                    setState(() {
                      _showSpinner = true;
                    });
                    try {
                      await _auth.createUserWithEmailAndPassword(
                          email: email, password: password);

                      if (!context.mounted) return;
                      Navigator.pushNamed(context, ChatScreen.id);

                      setState(() {
                        _showSpinner = false;
                      });
                    } on Exception catch (e) {
                      print(e);
                    }
                  },
                  buttonText: 'Register'),
            ],
          ),
        ),
      ),
    );
  }
}
