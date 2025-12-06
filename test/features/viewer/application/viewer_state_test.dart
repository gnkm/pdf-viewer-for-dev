import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdf_viewer_for_dev/features/viewer/application/viewer_state.dart';

void main() {
  group('ViewerNotifier', () {
    test('initial state is correct', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      
      final state = container.read(viewerProvider);
      expect(state.pageNumber, 1);
      expect(state.zoom, 1.0);
      expect(state.filePath, null);
    });

    test('setZoom updates zoom within limits', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(viewerProvider.notifier);
      notifier.setZoom(1.5);
      expect(container.read(viewerProvider).zoom, 1.5);
      
      notifier.setZoom(0.01); // Too small
      expect(container.read(viewerProvider).zoom, 0.1); // Min limit 0.1
      
      notifier.setZoom(10.0); // Too big
      expect(container.read(viewerProvider).zoom, 5.0); // Max limit 5.0
    });

    test('setPage updates page number', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(viewerProvider.notifier);
      notifier.setPage(5);
      expect(container.read(viewerProvider).pageNumber, 5);
      
      notifier.setPage(0);
      expect(container.read(viewerProvider).pageNumber, 1); // Min 1
    });
  });
}
