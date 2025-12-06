import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'key_binding_service.dart';

part 'input_providers.g.dart';

@Riverpod(keepAlive: true)
KeyBindingService keyBindingService(Ref ref) {
  return KeyBindingService();
}
