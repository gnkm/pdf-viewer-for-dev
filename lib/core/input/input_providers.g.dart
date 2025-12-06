// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'input_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(keyBindingService)
const keyBindingServiceProvider = KeyBindingServiceProvider._();

final class KeyBindingServiceProvider
    extends
        $FunctionalProvider<
          KeyBindingService,
          KeyBindingService,
          KeyBindingService
        >
    with $Provider<KeyBindingService> {
  const KeyBindingServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'keyBindingServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$keyBindingServiceHash();

  @$internal
  @override
  $ProviderElement<KeyBindingService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  KeyBindingService create(Ref ref) {
    return keyBindingService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(KeyBindingService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<KeyBindingService>(value),
    );
  }
}

String _$keyBindingServiceHash() => r'2c163cab6401109300511cbe107a33114c1ec21d';
