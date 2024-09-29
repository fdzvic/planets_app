final RegExp _emailRegExp = RegExp(
  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
);
String? validateEmail(String email, {String? matchValue}) {
  if (email.isEmpty) {
    return 'Introduce un correo';
  } else if (!_emailRegExp.hasMatch(email.trim())) {
    return 'Por favor introduce un correo válido';
  }

  /// Si es un campo de repetición
  if (matchValue != null) {
    return validateMatchValue(email, matchValue);
  }

  return null;
}

String? validatePassword(String input, {String? matchValue, bool? errorBack}) {
  if (matchValue != null) {
    return input.isEmpty && matchValue != ""
        ? 'Este campo es obligatorio'
        : input.isEmpty
            ? ''
            : null;
  } else {
    if (input.isEmpty) {
      return 'Este campo es obligatorio';
    }
  }

  if (errorBack!) {
    return '';
  }

  if (matchValue != null) {
    return validateMatchValue(input, matchValue);
  }
  return null;
}

String? validateChangePassword(String input,
    {String? matchValue, bool? errorBack}) {
  if (input.isEmpty) {
    return 'Este campo es obligatorio';
  }

  if (errorBack!) {
    return '';
  }

  if (matchValue != null) {
    return validateMatchValue(input, matchValue);
  }
  return null;
}

String? validateText(String input, {String? matchValue}) {
  if (input.isEmpty) {
    return 'Este campo es obligatorio';
  } else {
    // String pattern = r'^[a-zA-Z\s]*$';
    // RegExp regExp = RegExp(pattern);
    // if (!regExp.hasMatch(input)) {
    //   return 'Ingresa un nombre válido';
    // }

    /// Si es un campo de repetición
    if (matchValue != null) {
      return validateMatchValue(input, matchValue);
    }
    return null;
  }
}

String? validatePhone(String input, {String? matchValue}) {
  if (input.isEmpty || input.length != 8) {
    return 'Introduce un número de celular válido';
  }

  /// Si es un campo de repetición
  if (matchValue != null) {
    return validateMatchValue(input, matchValue);
  }
  return null;
}

String? validateDocument(input) {
  if (input.trim() == "") {
    return 'Escribe tu número de cédula';
  }
  if (input.trim().length != 13) {
    return 'Debes diligenciar un documento válido';
  }
  return null;
}

String? validateNumber(input) {
  if (input.isEmpty) {
    return 'Este campo es obligatorio';
  }
  if (!RegExp(r"^[0-9.,]*$").hasMatch(input)) {
    return 'Solo puede ingresar números';
  }

  if (input.contains('.') && input.contains(',') ||
      input.split('.').length > 2 ||
      input.split(',').length > 2) {
    return 'Numero incorrecto';
  }
  return null;
}

String? validateOtp(String input, bool errorBack, bool errorAttemps) {
  if (input.isEmpty) {
    return 'Este campo es obligatorio';
  }
  if (errorAttemps) {
    return 'Has superado los intentos permitidos para escribir tu PIN, recupera tu PIN para poder continuar.';
  }
  if (input.length < 6) {
    return 'Debes diligenciar el código completo para continuar.';
  }
  if (errorBack) {
    return 'Código incorrecto, corrige y vuelve a intentar';
  }

  return null;
}

// String? validateDropdown(
//   String input,
//   List<OptionsDropdown> options,
// ) {
//   if (input.isEmpty) {
//     return 'Este campo es obligatorio';
//   }

//   if (!(options.any((element) => element.nombre == input))) {
//     return "Texto no válido, selecciona una opción";
//   }

//   return null;
// }

String? validateMatchValue(String value, String match) => value != match
    ? 'Las contraseñas no coinciden. Corrige y vuelve a intentar'
    : null;

String? noValidate() => null;
