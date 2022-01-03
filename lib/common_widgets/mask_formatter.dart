import 'dart:math';
import 'package:flutter/services.dart';

final RegExp _digitRegExp = RegExp(r'[-0-9]+');

class MaskFormatter extends TextInputFormatter {
  final String mask;

  final String _anyCharMask = '#';
  final String _onlyDigitMask = '0';
  final RegExp? allowedCharMatcher;
  List<int> _separatorIndices = <int>[];
  List<String> _separatorChars = <String>[];
  String _maskedValue = '';
  MaskFormatter(
      this.mask, {
        this.allowedCharMatcher,
      });

  bool get isFilled => _maskedValue.length == mask.length;

  String get unmaskedValue {
    _prepareMask();
    final stringBuffer = StringBuffer();
    for (var i = 0; i < _maskedValue.length; i++) {
      var char = _maskedValue[i];
      if (!_separatorChars.contains(char)) {
        stringBuffer.write(char);
      }
    }
    return stringBuffer.toString();
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final FormattedValue oldFormattedValue = applyMask(
      oldValue.text,
    );
    final FormattedValue newFormattedValue = applyMask(
      newValue.text,
    );
    var numSeparatorsInNew = 0;
    var numSeparatorsInOld = 0;

    /// without this condition there might be a range exception
    if (oldValue.selection.end <= oldFormattedValue.text.length) {
      numSeparatorsInOld = _countSeparators(
        oldFormattedValue.text.substring(0, oldValue.selection.end),
      );
    }
    if (newValue.selection.end <= newFormattedValue.text.length) {
      numSeparatorsInNew = _countSeparators(
        newFormattedValue.text.substring(0, newValue.selection.end),
      );
    } else {
      numSeparatorsInNew = numSeparatorsInOld;
    }

    var separatorsDiff = (numSeparatorsInNew - numSeparatorsInOld);
    if (newFormattedValue._isErasing) {
      separatorsDiff = 0;
    }
    var selectionOffset = newValue.selection.end + separatorsDiff;
    _maskedValue = newFormattedValue.text;

    if (selectionOffset > _maskedValue.length) {
      selectionOffset = _maskedValue.length;
    }

    return TextEditingValue(
      text: _maskedValue,
      selection: TextSelection.collapsed(
        offset: selectionOffset,
        affinity: TextAffinity.upstream,
      ),
    );
  }

  bool _isMatchingRestrictor(String character) {
    if (allowedCharMatcher == null) {
      return true;
    }
    return allowedCharMatcher!.stringMatch(character) != null;
  }

  void _prepareMask() {
    if (_separatorIndices.isEmpty) {
      for (var i = 0; i < mask.length; i++) {
        if (mask[i] != _anyCharMask && mask[i] != _onlyDigitMask) {
          _separatorIndices.add(i);
          _separatorChars.add(mask[i]);
        }
      }
    }
  }

  int _countSeparators(String text) {
    _prepareMask();
    var numSeparators = 0;
    for (var i = 0; i < text.length; i++) {
      if (_separatorChars.contains(text[i])) {
        numSeparators++;
      }
    }
    return numSeparators;
  }

  String _removeSeparators(String text) {
    var stringBuffer = StringBuffer();
    for (var i = 0; i < text.length; i++) {
      var char = text[i];
      if (!_separatorChars.contains(char)) {
        stringBuffer.write(char);
      }
    }
    return stringBuffer.toString();
  }

  FormattedValue applyMask(String text) {
    _prepareMask();
    String clearedValueAfter = _removeSeparators(text);
    final isErasing = _maskedValue.length > text.length;
    FormattedValue formattedValue = FormattedValue();
    StringBuffer stringBuffer = StringBuffer();
    var index = 0;
    final maxLength = min(
      clearedValueAfter.length,
      mask.length - _separatorChars.length,
    );

    for (var i = 0; i < maxLength; i++) {
      final curChar = clearedValueAfter[i];
      final charInMask = mask[i];
      final maskOnDigitMatcher = charInMask == _onlyDigitMask;
      if (maskOnDigitMatcher) {
        if (!isDigit(curChar)) {
          continue;
        }
      } else {
        if (!_isMatchingRestrictor(curChar)) {
          continue;
        }
      }
      if (_separatorIndices.contains(index)) {
        stringBuffer.write(mask[index]);
        index++;
      }
      stringBuffer.write(curChar);
      index++;
    }
    formattedValue._isErasing = isErasing;
    formattedValue._formattedValue = stringBuffer.toString();

    return formattedValue;
  }
}

class FormattedValue {
  String _formattedValue = '';
  bool _isErasing = false;

  String get text {
    return _formattedValue;
  }

  @override
  String toString() {
    return _formattedValue;
  }
}

bool isDigit(String? character) {
  if (character == null || character.isEmpty || character.length > 1) {
    return false;
  }
  return _digitRegExp.stringMatch(character) != null;
}