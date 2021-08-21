import 'package:flutter/material.dart';
import 'package:app/signIn/footer.dart';
import 'package:app/signIn/textForm.dart';
import 'package:app/signIn/header.dart';

const Color kAccentColor = Color(0xFFFE7C64);
const Color kBackgroundColor = Color(0xFF19283D);
const Color kTextColorPrimary = Color(0xFFECEFF1);
const Color kTextColorSecondary = Color(0xFFB0BEC5);
const Color kButtonColorPrimary = Color(0xFFECEFF1);
const Color kButtonTextColorPrimary = Color(0xFF455A64);
const Color kIconColor = Color(0xFF455A64);

// ignore: use_key_in_widget_constructors
class SignUpSignInWelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // この中にヘッダー、フォーム、フッダーを書いていく
              Header(),
              const Padding(
                // 親要素でサイズ指定して、内部のボタンはinfiniteにする
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: SignInForm(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 64),
                child: Footer(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
