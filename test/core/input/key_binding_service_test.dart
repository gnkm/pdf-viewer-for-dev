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
      const input = KeyInput(PhysicalKeyboardKey.keyN, isControl: true);
      expect(service.getAction(input, AppMode.emacs), ViewerAction.nextPage);
    });

    test('Emacs: C-p maps to previousPage', () {
      const input = KeyInput(PhysicalKeyboardKey.keyP, isControl: true);
      expect(
        service.getAction(input, AppMode.emacs),
        ViewerAction.previousPage,
      );
    });

    test('Vim: j maps to nextPage', () {
      const input = KeyInput(PhysicalKeyboardKey.keyJ);
      expect(service.getAction(input, AppMode.vim), ViewerAction.nextPage);
    });

    test('Vim: k maps to previousPage', () {
      const input = KeyInput(PhysicalKeyboardKey.keyK);
      expect(service.getAction(input, AppMode.vim), ViewerAction.previousPage);
    });

    test('Common: C-s maps to search', () {
      const input = KeyInput(PhysicalKeyboardKey.keyS, isControl: true);
      expect(service.getAction(input, AppMode.emacs), ViewerAction.search);
    });

    test('Vim: / maps to search', () {
      const input = KeyInput(PhysicalKeyboardKey.slash);
      expect(service.getAction(input, AppMode.vim), ViewerAction.search);
    });

    test('Vim: n maps to nextSearchMatch', () {
      const input = KeyInput(PhysicalKeyboardKey.keyN);
      expect(
        service.getAction(input, AppMode.vim),
        ViewerAction.nextSearchMatch,
      );
    });

    test('Vim: N (Shift+n) maps to previousSearchMatch', () {
      const input = KeyInput(PhysicalKeyboardKey.keyN, isShift: true);
      expect(
        service.getAction(input, AppMode.vim),
        ViewerAction.previousSearchMatch,
      );
    });

    test('Common: ArrowDown maps to nextPage', () {
      const input = KeyInput(PhysicalKeyboardKey.arrowDown);
      expect(service.getAction(input, AppMode.emacs), ViewerAction.nextPage);
      expect(service.getAction(input, AppMode.vim), ViewerAction.nextPage);
    });

    test('Common: ArrowUp maps to previousPage', () {
      const input = KeyInput(PhysicalKeyboardKey.arrowUp);
      expect(
        service.getAction(input, AppMode.emacs),
        ViewerAction.previousPage,
      );
      expect(service.getAction(input, AppMode.vim), ViewerAction.previousPage);
    });

    // Emacs Jump keys
    test('Emacs: M-< maps to firstPage', () {
      const input = KeyInput(
        PhysicalKeyboardKey.comma,
        isAlt: true,
        isShift: true,
      );
      expect(service.getAction(input, AppMode.emacs), ViewerAction.firstPage);
    });

    test('Emacs: M-> maps to lastPage', () {
      const input = KeyInput(
        PhysicalKeyboardKey.period,
        isAlt: true,
        isShift: true,
      );
      expect(service.getAction(input, AppMode.emacs), ViewerAction.lastPage);
    });

    // Vim Jump keys
    test('Vim: 0 does not map to any action (gg not implemented yet)', () {
      const input = KeyInput(PhysicalKeyboardKey.digit0);
      expect(service.getAction(input, AppMode.vim), isNull);
    });

    test('Vim: G maps to lastPage', () {
      const input = KeyInput(PhysicalKeyboardKey.keyG, isShift: true);
      expect(service.getAction(input, AppMode.vim), ViewerAction.lastPage);
    });

    test('Vim: Ctrl+0 maps to zoomReset', () {
      const input = KeyInput(PhysicalKeyboardKey.digit0, isControl: true);
      expect(service.getAction(input, AppMode.vim), ViewerAction.zoomReset);
    });

    // Numeric Percentage Jumps
    test('Common: 5 maps to jumpPage50', () {
      const input = KeyInput(PhysicalKeyboardKey.digit5);
      expect(service.getAction(input, AppMode.emacs), ViewerAction.jumpPage50);
      expect(service.getAction(input, AppMode.vim), ViewerAction.jumpPage50);
    });
  });
}
