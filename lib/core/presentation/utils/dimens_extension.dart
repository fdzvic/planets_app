import 'package:flutter/material.dart';

///
/// Esta clase retorna el valor del alto y ancho de la pantalla o un EdgeInsets respecto caclulado con un porcentaje dado y la medida en MediaQuey
///

extension DimensExtension on BuildContext {
  /// Ancho total de la pantalla.
  double width([num? value]) {
    if (value != null) {
      return MediaQuery.of(this).size.width * value;
    }
    return MediaQuery.of(this).size.width;
  }

  /// Largo total de la pantalla.
  double height([num? value]) {
    if (value != null) {
      return MediaQuery.of(this).size.height * value;
    }
    return MediaQuery.of(this).size.height;
  }

  ///
  EdgeInsets fromLTRB(num left, num top, num right, num bottom) {
    return EdgeInsets.fromLTRB(
      width() * left,
      width() * top,
      width() * right,
      width() * bottom,
    );
  }

  ///
  EdgeInsets symetric(num horizontal, num vertical) {
    return EdgeInsets.symmetric(
      vertical: width() * vertical,
      horizontal: width() * horizontal,
    );
  }

  ///
  EdgeInsets all(num value) => EdgeInsets.all(width() * value);

  ///
  EdgeInsets horizontal(num value) =>
      EdgeInsets.symmetric(horizontal: width() * value);

  ///
  EdgeInsets vertical(num value) =>
      EdgeInsets.symmetric(vertical: width() * value);

  ///
  EdgeInsets top(num value) => EdgeInsets.only(top: width() * value);

  ///
  EdgeInsets left(num value) => EdgeInsets.only(left: width() * value);

  ///
  EdgeInsets right(value) => EdgeInsets.only(right: width() * value);

  ///
  EdgeInsets bottom(value) => EdgeInsets.only(bottom: width() * value);
}
