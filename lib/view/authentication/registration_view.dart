import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:kat_chat/view/authentication/sign_up_view.dart';

import 'sign_in_view.dart';
import 'widgets/registration_widget.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({Key? key}) : super(key: key);

  @override
  _RegistrationViewState createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 50.0,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    ScaleAnimatedText('Kat'),
                    ScaleAnimatedText('Chat'),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
                child: RegistrationWidget(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignInView(),
                          ));
                    },
                    text: 'Кируу')),
            const SizedBox(
              height: 20,
            ),
            Center(
                child: RegistrationWidget(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpView(),
                          ));
                    },
                    text: 'Катталуу')),
          ],
        ),
      ),
    );
  }
}
