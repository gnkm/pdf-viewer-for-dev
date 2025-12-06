import 'package:flutter/services.dart';
import 'package:pdf_viewer_for_dev/core/config/app_mode.dart';
import 'input_models.dart';
import 'viewer_action.dart';

class KeyBindingService {
  final Map<AppMode, Map<KeyInput, ViewerAction>> _bindings = {};

  KeyBindingService() {
    _initBindings();
  }

  ViewerAction? getAction(KeyInput input, AppMode mode) {
    return _bindings[mode]?[input];
  }

  void _initBindings() {
    _bindings[AppMode.emacs] = {
      // Navigation
      const KeyInput(PhysicalKeyboardKey.keyN, isControl: true):
          ViewerAction.nextPage,
      const KeyInput(PhysicalKeyboardKey.keyP, isControl: true):
          ViewerAction.previousPage,
      const KeyInput(PhysicalKeyboardKey.comma, isAlt: true, isShift: true):
          ViewerAction.firstPage, // M-<
      const KeyInput(PhysicalKeyboardKey.period, isAlt: true, isShift: true):
          ViewerAction.lastPage, // M->
      // Search
      const KeyInput(PhysicalKeyboardKey.keyS, isControl: true):
          ViewerAction.search,

      // File operations (Cmd + O for open file - macOS では C-x C-f が使えないため)
      const KeyInput(PhysicalKeyboardKey.keyO, isMeta: true):
          ViewerAction.openFile,

      // Zoom operations (Cmd + +/-, Cmd + 0, Cmd + Shift + ;)
      const KeyInput(PhysicalKeyboardKey.equal, isMeta: true, isShift: true):
          ViewerAction.zoomIn, // Cmd + +
      const KeyInput(PhysicalKeyboardKey.numpadAdd, isMeta: true):
          ViewerAction.zoomIn, // Cmd + + (numpad)
      const KeyInput(
        PhysicalKeyboardKey.semicolon,
        isMeta: true,
        isShift: true,
      ): ViewerAction.zoomIn, // Cmd + Shift + ;
      const KeyInput(PhysicalKeyboardKey.minus, isMeta: true):
          ViewerAction.zoomOut, // Cmd + -
      const KeyInput(PhysicalKeyboardKey.numpadSubtract, isMeta: true):
          ViewerAction.zoomOut, // Cmd + - (numpad)
      const KeyInput(PhysicalKeyboardKey.digit0, isMeta: true):
          ViewerAction.zoomReset, // Cmd + 0
      const KeyInput(PhysicalKeyboardKey.numpad0, isMeta: true):
          ViewerAction.zoomReset, // Cmd + 0 (numpad)
    };

    _bindings[AppMode.vim] = {
      // Navigation
      const KeyInput(PhysicalKeyboardKey.keyJ): ViewerAction.nextPage,
      const KeyInput(PhysicalKeyboardKey.keyK): ViewerAction.previousPage,
      // Note: gg (firstPage) is handled by key sequence detection in PdfViewerPage
      const KeyInput(PhysicalKeyboardKey.keyG, isShift: true):
          ViewerAction.lastPage, // G -> Shift + g
      // Search
      const KeyInput(PhysicalKeyboardKey.slash): ViewerAction.search,
      // Search navigation (n/N for next/previous match)
      const KeyInput(PhysicalKeyboardKey.keyN, isShift: false):
          ViewerAction.nextSearchMatch, // n
      const KeyInput(PhysicalKeyboardKey.keyN, isShift: true):
          ViewerAction.previousSearchMatch, // N
      // Percentage Jump (1-9 only, as per requirements)
      const KeyInput(PhysicalKeyboardKey.digit1): ViewerAction.jumpPage10,
      const KeyInput(PhysicalKeyboardKey.digit2): ViewerAction.jumpPage20,
      const KeyInput(PhysicalKeyboardKey.digit3): ViewerAction.jumpPage30,
      const KeyInput(PhysicalKeyboardKey.digit4): ViewerAction.jumpPage40,
      const KeyInput(PhysicalKeyboardKey.digit5): ViewerAction.jumpPage50,
      const KeyInput(PhysicalKeyboardKey.digit6): ViewerAction.jumpPage60,
      const KeyInput(PhysicalKeyboardKey.digit7): ViewerAction.jumpPage70,
      const KeyInput(PhysicalKeyboardKey.digit8): ViewerAction.jumpPage80,
      const KeyInput(PhysicalKeyboardKey.digit9): ViewerAction.jumpPage90,

      // Arrow Keys
      const KeyInput(PhysicalKeyboardKey.arrowDown): ViewerAction.nextPage,
      const KeyInput(PhysicalKeyboardKey.arrowUp): ViewerAction.previousPage,

      // File operations (Cmd + O for open file)
      const KeyInput(PhysicalKeyboardKey.keyO, isMeta: true):
          ViewerAction.openFile,

      // Zoom operations (Ctrl + +/-, Ctrl + 0)
      const KeyInput(PhysicalKeyboardKey.equal, isControl: true, isShift: true):
          ViewerAction.zoomIn, // Ctrl + +
      const KeyInput(PhysicalKeyboardKey.numpadAdd, isControl: true):
          ViewerAction.zoomIn, // Ctrl + + (numpad)
      const KeyInput(PhysicalKeyboardKey.minus, isControl: true):
          ViewerAction.zoomOut, // Ctrl + -
      const KeyInput(PhysicalKeyboardKey.numpadSubtract, isControl: true):
          ViewerAction.zoomOut, // Ctrl + - (numpad)
      const KeyInput(PhysicalKeyboardKey.digit0, isControl: true):
          ViewerAction.zoomReset, // Ctrl + 0
      const KeyInput(PhysicalKeyboardKey.numpad0, isControl: true):
          ViewerAction.zoomReset, // Ctrl + 0 (numpad)
    };

    // Copy numeric keys to Emacs as well since requirements list them for both (or implies common)
    _bindings[AppMode.emacs]!.addAll({
      const KeyInput(PhysicalKeyboardKey.digit1): ViewerAction.jumpPage10,
      const KeyInput(PhysicalKeyboardKey.digit2): ViewerAction.jumpPage20,
      const KeyInput(PhysicalKeyboardKey.digit3): ViewerAction.jumpPage30,
      const KeyInput(PhysicalKeyboardKey.digit4): ViewerAction.jumpPage40,
      const KeyInput(PhysicalKeyboardKey.digit5): ViewerAction.jumpPage50,
      const KeyInput(PhysicalKeyboardKey.digit6): ViewerAction.jumpPage60,
      const KeyInput(PhysicalKeyboardKey.digit7): ViewerAction.jumpPage70,
      const KeyInput(PhysicalKeyboardKey.digit8): ViewerAction.jumpPage80,
      const KeyInput(PhysicalKeyboardKey.digit9): ViewerAction.jumpPage90,

      // Arrow Keys support (for Karabiner users etc)
      const KeyInput(PhysicalKeyboardKey.arrowDown): ViewerAction.nextPage,
      const KeyInput(PhysicalKeyboardKey.arrowUp): ViewerAction.previousPage,
    });
  }
}
