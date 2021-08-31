import 'package:flutter/material.dart';
import 'package:app/signIn/main.dart';

// フォーム要素
// フォーム部分を使いまわして実装するためのクラス
class _CustomTextFrom extends StatelessWidget {
  final String labelText;
  final String hintText;
  final bool obscureText;

  const _CustomTextFrom({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: () {},
      obscureText: obscureText, // 入力内容を隠すか
      decoration: InputDecoration(
        labelText: labelText, // フォームの右上に表示するラベル
        hintText: hintText, // プレースホルダー
        hintStyle: const TextStyle(color: kTextColorSecondary),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: OutlineInputBorder(
          // 選択していないときのフォームスタイル
          borderRadius: BorderRadius.circular(8),
          borderSide:
              const BorderSide(color: kTextColorSecondary), // ラベルを上に表示するか？
        ),
        focusedBorder: OutlineInputBorder(
          // 選択しているときのフォームスタイル
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: kAccentColor,
          ),
        ),
      ),
    );
  }
}

class SignInForm extends StatelessWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _CustomTextFrom(
          labelText: 'Email',
          hintText: 'your email address goes here',
          obscureText: false,
        ),
        SizedBox(
          height: 48,
        ),
        const _CustomTextFrom(
          labelText: 'Password',
          hintText: 'your password goes here',
          obscureText: true,
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          "Forgot Password?",
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: kTextColorSecondary),
        ),
        SizedBox(
          height: 48,
        ),
        // ポストするボタン
        Container(
          width: double.infinity,
          child: TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              primary: kButtonTextColorPrimary,
              backgroundColor: kButtonColorPrimary,
              padding: const EdgeInsets.symmetric(vertical: 16), // ボタン内の縦余白
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              "Sign in",
              style: Theme.of(context)
                  .textTheme
                  .button!
                  .copyWith(color: kButtonTextColorPrimary, fontSize: 18),
            ),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          'OR',
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: kTextColorSecondary),
        ),
        SizedBox(height: 16),
        Text(
          'Connect with',
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: kTextColorPrimary),
        ),
        SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {},
            ),
            Container(
              color: kTextColorSecondary,
              width: 1,
              height: 16,
            ),
            IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {},
            ),
          ],
        )
      ],
    );
  }
}
