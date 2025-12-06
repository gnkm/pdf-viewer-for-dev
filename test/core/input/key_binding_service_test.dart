import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdf_viewer_for_dev/core/config/app_mode.dart';
import 'package:pdf_viewer_for_dev/core/input/input_models.dart';
import 'package:pdf_viewer_for_dev/core/input/key_binding_service.dart';
import 'package:pdf_viewer_for_dev/core/input/viewer_action.dart';

void main() {
  group('KeyBindingService', () {
    final service = KeyBindingService();

    test('Emacs: C-n maps to nextPage', () {
      final input = KeyInput(PhysicalKeyboardKey.keyN, isControl: true);
      expect(service.getAction(input, AppMode.emacs), ViewerAction.nextPage);
    });

    test('Emacs: C-p maps to previousPage', () {
      final input = KeyInput(PhysicalKeyboardKey.keyP, isControl: true);
      expect(service.getAction(input, AppMode.emacs), ViewerAction.previousPage);
    });

    test('Vim: j maps to nextPage', () {
      final input = KeyInput(PhysicalKeyboardKey.keyJ);
      expect(service.getAction(input, AppMode.vim), ViewerAction.nextPage);
    });

    test('Vim: k maps to previousPage', () {
      final input = KeyInput(PhysicalKeyboardKey.keyK);
      expect(service.getAction(input, AppMode.vim), ViewerAction.previousPage);
    });

    test('Common: C-s maps to search', () {
      final input = KeyInput(PhysicalKeyboardKey.keyS, isControl: true);
      expect(service.getAction(input, AppMode.emacs), ViewerAction.search);
    });
    
    test('Vim: / maps to search', () {
       final input = KeyInput(PhysicalKeyboardKey.slash);
       expect(service.getAction(input, AppMode.vim), ViewerAction.search);
    });

    test('Common: ArrowDown maps to nextPage', () {
      final input = KeyInput(PhysicalKeyboardKey.arrowDown);
      expect(service.getAction(input, AppMode.emacs), ViewerAction.nextPage);
      expect(service.getAction(input, AppMode.vim), ViewerAction.nextPage);
    });

    test('Common: ArrowUp maps to previousPage', () {
      final input = KeyInput(PhysicalKeyboardKey.arrowUp);
      expect(service.getAction(input, AppMode.emacs), ViewerAction.previousPage);
      expect(service.getAction(input, AppMode.vim), ViewerAction.previousPage);
    });

    // Emacs Jump keys
    test('Emacs: M-< maps to firstPage', () {
      final input = KeyInput(PhysicalKeyboardKey.comma, isAlt: true, isShift: true);
      expect(service.getAction(input, AppMode.emacs), ViewerAction.firstPage);
    });

    test('Emacs: M-> maps to lastPage', () {
      final input = KeyInput(PhysicalKeyboardKey.period, isAlt: true, isShift: true);
      expect(service.getAction(input, AppMode.emacs), ViewerAction.lastPage);
    });

    // Vim Jump keys
    test('Vim: 0 does not map to any action (gg not implemented yet)', () {
      final input = KeyInput(PhysicalKeyboardKey.digit0);
      expect(service.getAction(input, AppMode.vim), isNull);
    });

    test('Vim: G maps to lastPage', () {
      final input = KeyInput(PhysicalKeyboardKey.keyG, isShift: true);
      expect(service.getAction(input, AppMode.vim), ViewerAction.lastPage);
    });

    test('Vim: Ctrl+0 maps to zoomReset', () {
      final input = KeyInput(PhysicalKeyboardKey.digit0, isControl: true);
      expect(service.getAction(input, AppMode.vim), ViewerAction.zoomReset);
    });

    // Numeric Percentage Jumps
    test('Common: 5 maps to jumpPage50', () {
      final input = KeyInput(PhysicalKeyboardKey.digit5);
      expect(service.getAction(input, AppMode.emacs), ViewerAction.jumpPage50);
      expect(service.getAction(input, AppMode.vim), ViewerAction.jumpPage50);
    });
  });
}
