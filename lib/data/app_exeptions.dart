class AppExeption implements Exception {
  // ignore: prefer_typing_uninitialized_variables
  final _message;
  // ignore: prefer_typing_uninitialized_variables
  final _prefix;

  AppExeption([this._message, this._prefix]);

  // ignore: annotate_overrides
  String toString() {
    return '$_prefix$_message';
  }
}

class FetchDataExeption extends AppExeption {
  FetchDataExeption([String? message])
      : super(message, 'Error During Comunication');
}

class BadRequestExeption extends AppExeption {
  BadRequestExeption([String? message]) : super(message, 'Invalid Request');
}

class UnautoriseExeption extends AppExeption {
  UnautoriseExeption([String? message]) : super(message, 'Unautorised Request');
}

class InvalidInputExeption extends AppExeption {
  InvalidInputExeption([String? message]) : super(message, 'Invalid Input');
}
