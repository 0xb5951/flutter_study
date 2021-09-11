import 'package:flutter/material.dart';
import 'dart:math' as math;

class UrlComponent {
  // lengthで指定された長さのランダムな文字列を生成する
  String randomString(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final rand = math.Random.secure();
    final codeUnit = List.generate(length, (index) {
      // charsの文字列からランダムなインデックスを指定する
      final n = rand.nextInt(chars.length);
      // 指定したインデックスの文字列をUTF-16のコードに変換して返す。ex. 0x41 = A
      return chars.codeUnitAt(n);
    });
    // codeUnitにはUTF-16化した文字コードのリストが入っている
    return String.fromCharCodes(codeUnit);
  }
}
