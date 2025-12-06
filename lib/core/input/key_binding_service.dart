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
      const KeyInput(PhysicalKeyboardKey.keyN, isControl: true): ViewerAction.nextPage,
      const KeyInput(PhysicalKeyboardKey.keyP, isControl: true): ViewerAction.previousPage,
      const KeyInput(PhysicalKeyboardKey.comma, isAlt: true, isShift: true): ViewerAction.firstPage, // M-<
      const KeyInput(PhysicalKeyboardKey.period, isAlt: true, isShift: true): ViewerAction.lastPage, // M->
      
      // Search
      const KeyInput(PhysicalKeyboardKey.keyS, isControl: true): ViewerAction.search,
    };

    _bindings[AppMode.vim] = {
      // Navigation
      const KeyInput(PhysicalKeyboardKey.keyJ): ViewerAction.nextPage,
      const KeyInput(PhysicalKeyboardKey.keyK): ViewerAction.previousPage,
      const KeyInput(PhysicalKeyboardKey.digit0): ViewerAction.firstPage,
      const KeyInput(PhysicalKeyboardKey.keyG, isShift: true): ViewerAction.lastPage, // G -> Shift + g

      // Search
      const KeyInput(PhysicalKeyboardKey.slash): ViewerAction.search,

      // Percentage Jump
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
