import 'package:flutter/services.dart';

class CustomRangeTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    if (newValue.text == '') {
      return const TextEditingValue();
    } else if (int.parse(newValue.text) < 1) {
      return const TextEditingValue().copyWith(text: '1');
    }

    return int.parse(newValue.text) > 34
        ? const TextEditingValue().copyWith(text: '34')
        : newValue;
  }
}
