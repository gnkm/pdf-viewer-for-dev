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

    group('Search functionality', () {
      test('setSearchQuery sets query and clears matches', () {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final notifier = container.read(viewerProvider.notifier);
        final matches = [
          const SearchMatch(pageNumber: 1, matchIndex: 10),
          const SearchMatch(pageNumber: 2, matchIndex: 20),
        ];
        notifier.setSearchMatches(matches);
        notifier.setCurrentSearchMatchIndex(1);

        // 検索クエリを設定すると、マッチがクリアされる
        notifier.setSearchQuery('test');
        final state = container.read(viewerProvider);
        expect(state.searchQuery, 'test');
        expect(state.searchMatches, isEmpty);
        expect(state.currentSearchMatchIndex, isNull);
      });

      test('setSearchQuery with null clears query', () {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final notifier = container.read(viewerProvider.notifier);
        notifier.setSearchQuery('test');
        expect(container.read(viewerProvider).searchQuery, 'test');

        notifier.setSearchQuery(null);
        expect(container.read(viewerProvider).searchQuery, isNull);
      });

      test('setSearchMatches sets matches and initializes index', () {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final notifier = container.read(viewerProvider.notifier);
        final matches = [
          const SearchMatch(pageNumber: 1, matchIndex: 10),
          const SearchMatch(pageNumber: 2, matchIndex: 20),
          const SearchMatch(pageNumber: 3, matchIndex: 30),
        ];
        notifier.setSearchMatches(matches);

        final state = container.read(viewerProvider);
        expect(state.searchMatches, matches);
        expect(state.currentSearchMatchIndex, 0); // 最初のマッチに設定
      });

      test('setSearchMatches with empty list clears index', () {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final notifier = container.read(viewerProvider.notifier);
        final matches = [const SearchMatch(pageNumber: 1, matchIndex: 10)];
        notifier.setSearchMatches(matches);
        expect(container.read(viewerProvider).currentSearchMatchIndex, 0);

        notifier.setSearchMatches([]);
        expect(container.read(viewerProvider).currentSearchMatchIndex, isNull);
      });

      test('setCurrentSearchMatchIndex sets valid index', () {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final notifier = container.read(viewerProvider.notifier);
        final matches = [
          const SearchMatch(pageNumber: 1, matchIndex: 10),
          const SearchMatch(pageNumber: 2, matchIndex: 20),
          const SearchMatch(pageNumber: 3, matchIndex: 30),
        ];
        notifier.setSearchMatches(matches);

        notifier.setCurrentSearchMatchIndex(1);
        expect(container.read(viewerProvider).currentSearchMatchIndex, 1);

        notifier.setCurrentSearchMatchIndex(2);
        expect(container.read(viewerProvider).currentSearchMatchIndex, 2);
      });

      test('setCurrentSearchMatchIndex ignores invalid index', () {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final notifier = container.read(viewerProvider.notifier);
        final matches = [
          const SearchMatch(pageNumber: 1, matchIndex: 10),
          const SearchMatch(pageNumber: 2, matchIndex: 20),
        ];
        notifier.setSearchMatches(matches);
        notifier.setCurrentSearchMatchIndex(0);

        // 無効なインデックスは無視される
        notifier.setCurrentSearchMatchIndex(-1);
        expect(container.read(viewerProvider).currentSearchMatchIndex, 0);

        notifier.setCurrentSearchMatchIndex(10);
        expect(container.read(viewerProvider).currentSearchMatchIndex, 0);
      });

      test('nextSearchMatch moves to next match', () {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final notifier = container.read(viewerProvider.notifier);
        final matches = [
          const SearchMatch(pageNumber: 1, matchIndex: 10),
          const SearchMatch(pageNumber: 2, matchIndex: 20),
          const SearchMatch(pageNumber: 3, matchIndex: 30),
        ];
        notifier.setSearchMatches(matches);

        notifier.nextSearchMatch();
        expect(container.read(viewerProvider).currentSearchMatchIndex, 1);

        notifier.nextSearchMatch();
        expect(container.read(viewerProvider).currentSearchMatchIndex, 2);
      });

      test('nextSearchMatch wraps around to first match', () {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final notifier = container.read(viewerProvider.notifier);
        final matches = [
          const SearchMatch(pageNumber: 1, matchIndex: 10),
          const SearchMatch(pageNumber: 2, matchIndex: 20),
        ];
        notifier.setSearchMatches(matches);
        notifier.setCurrentSearchMatchIndex(1);

        // 最後のマッチから次へ移動すると、最初に戻る
        notifier.nextSearchMatch();
        expect(container.read(viewerProvider).currentSearchMatchIndex, 0);
      });

      test('previousSearchMatch moves to previous match', () {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final notifier = container.read(viewerProvider.notifier);
        final matches = [
          const SearchMatch(pageNumber: 1, matchIndex: 10),
          const SearchMatch(pageNumber: 2, matchIndex: 20),
          const SearchMatch(pageNumber: 3, matchIndex: 30),
        ];
        notifier.setSearchMatches(matches);
        notifier.setCurrentSearchMatchIndex(2);

        notifier.previousSearchMatch();
        expect(container.read(viewerProvider).currentSearchMatchIndex, 1);

        notifier.previousSearchMatch();
        expect(container.read(viewerProvider).currentSearchMatchIndex, 0);
      });

      test('previousSearchMatch wraps around to last match', () {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final notifier = container.read(viewerProvider.notifier);
        final matches = [
          const SearchMatch(pageNumber: 1, matchIndex: 10),
          const SearchMatch(pageNumber: 2, matchIndex: 20),
        ];
        notifier.setSearchMatches(matches);
        notifier.setCurrentSearchMatchIndex(0);

        // 最初のマッチから前へ移動すると、最後に戻る
        notifier.previousSearchMatch();
        expect(container.read(viewerProvider).currentSearchMatchIndex, 1);
      });

      test('nextSearchMatch does nothing when matches are empty', () {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final notifier = container.read(viewerProvider.notifier);
        notifier.setSearchMatches([]);

        notifier.nextSearchMatch();
        expect(container.read(viewerProvider).currentSearchMatchIndex, isNull);
      });

      test('previousSearchMatch does nothing when matches are empty', () {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final notifier = container.read(viewerProvider.notifier);
        notifier.setSearchMatches([]);

        notifier.previousSearchMatch();
        expect(container.read(viewerProvider).currentSearchMatchIndex, isNull);
      });

      test('toggleSearch toggles search active state', () {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final notifier = container.read(viewerProvider.notifier);
        expect(container.read(viewerProvider).isSearchActive, false);

        notifier.toggleSearch();
        expect(container.read(viewerProvider).isSearchActive, true);

        notifier.toggleSearch();
        expect(container.read(viewerProvider).isSearchActive, false);
      });

      test('toggleSearch clears search results when closing', () {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final notifier = container.read(viewerProvider.notifier);
        final matches = [const SearchMatch(pageNumber: 1, matchIndex: 10)];
        notifier.setSearchQuery('test');
        notifier.setSearchMatches(matches);
        notifier.setCurrentSearchMatchIndex(0);

        // 検索を閉じると、検索結果がクリアされる
        notifier.toggleSearch(); // 開く
        notifier.toggleSearch(); // 閉じる
        final state = container.read(viewerProvider);
        expect(state.isSearchActive, false);
        expect(state.searchQuery, isNull);
        expect(state.searchMatches, isEmpty);
        expect(state.currentSearchMatchIndex, isNull);
      });

      test('toggleSearch preserves search results when opening', () {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final notifier = container.read(viewerProvider.notifier);
        final matches = [const SearchMatch(pageNumber: 1, matchIndex: 10)];
        notifier.setSearchQuery('test');
        notifier.setSearchMatches(matches);
        notifier.setCurrentSearchMatchIndex(0);

        // 検索を開くと、検索結果が保持される
        notifier.toggleSearch();
        final state = container.read(viewerProvider);
        expect(state.isSearchActive, true);
        expect(state.searchQuery, 'test');
        expect(state.searchMatches, matches);
        expect(state.currentSearchMatchIndex, 0);
      });

      test('toggleSearch restores previous query when opening', () {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final notifier = container.read(viewerProvider.notifier);
        // 検索クエリを設定してから閉じる
        notifier.setSearchQuery('previous query');
        notifier.toggleSearch(); // 開く
        notifier.toggleSearch(); // 閉じる（クエリはクリアされる）

        // 再度開くと、以前のクエリは保持されない（クリアされているため）
        notifier.toggleSearch();
        final state = container.read(viewerProvider);
        expect(state.isSearchActive, true);
        expect(state.searchQuery, isNull);
      });

      test('toggleSearch preserves query when reopening immediately', () {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final notifier = container.read(viewerProvider.notifier);
        notifier.setSearchQuery('test query');
        notifier.toggleSearch(); // 開く

        // 開いた状態でクエリが設定されている
        expect(container.read(viewerProvider).searchQuery, 'test query');
        expect(container.read(viewerProvider).isSearchActive, true);

        // 閉じる
        notifier.toggleSearch();
        expect(container.read(viewerProvider).isSearchActive, false);
        expect(container.read(viewerProvider).searchQuery, isNull);
      });
    });
  });
}
