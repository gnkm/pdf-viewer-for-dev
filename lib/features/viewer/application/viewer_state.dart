import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pdf_viewer_for_dev/core/config/app_mode.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'viewer_state.freezed.dart';
part 'viewer_state.g.dart';

@freezed
abstract class SearchMatch with _$SearchMatch {
  const factory SearchMatch({
    required int pageNumber,
    required int matchIndex,
  }) = _SearchMatch;
}

@freezed
abstract class ViewerState with _$ViewerState {
  const factory ViewerState({
    @Default(1) int pageNumber,
    @Default(1.0) double zoom,
    String? filePath,
    @Default(AppMode.vim) AppMode mode,
    @Default(false) bool isSearchActive,
    String? searchQuery,
    @Default([]) List<SearchMatch> searchMatches,
    int? currentSearchMatchIndex,
  }) = _ViewerState;
}

@riverpod
class ViewerNotifier extends _$ViewerNotifier {
  // ...
  void toggleSearch() {
    final newIsSearchActive = !state.isSearchActive;
    state = state.copyWith(
      isSearchActive: newIsSearchActive,
      // 検索を閉じる際に検索結果をクリア
      searchQuery: newIsSearchActive ? state.searchQuery : null,
      searchMatches: newIsSearchActive ? state.searchMatches : [],
      currentSearchMatchIndex: newIsSearchActive
          ? state.currentSearchMatchIndex
          : null,
    );
  }

  void setSearchQuery(String? query) {
    state = state.copyWith(
      searchQuery: query,
      searchMatches: [],
      currentSearchMatchIndex: null,
    );
  }

  void setSearchMatches(List<SearchMatch> matches) {
    state = state.copyWith(
      searchMatches: matches,
      currentSearchMatchIndex: matches.isNotEmpty ? 0 : null,
    );
  }

  void setCurrentSearchMatchIndex(int? index) {
    if (index != null && index >= 0 && index < state.searchMatches.length) {
      state = state.copyWith(currentSearchMatchIndex: index);
    }
  }

  void nextSearchMatch() {
    if (state.searchMatches.isEmpty) {
      return;
    }
    final currentIndex = state.currentSearchMatchIndex ?? -1;
    final nextIndex = (currentIndex + 1) % state.searchMatches.length;
    setCurrentSearchMatchIndex(nextIndex);
  }

  void previousSearchMatch() {
    if (state.searchMatches.isEmpty) {
      return;
    }
    final currentIndex = state.currentSearchMatchIndex ?? 0;
    final prevIndex =
        (currentIndex - 1 + state.searchMatches.length) %
        state.searchMatches.length;
    setCurrentSearchMatchIndex(prevIndex);
  }

  // ...
  @override
  ViewerState build() {
    return const ViewerState();
  }

  void setZoom(double value) {
    final clamped = value.clamp(0.1, 5.0).toDouble();
    state = state.copyWith(zoom: clamped);
  }

  void setPage(int page) {
    final validPage = page < 1 ? 1 : page;
    // We ideally need max pages, but that depends on loaded doc.
    // For now simple clamp to min.
    state = state.copyWith(pageNumber: validPage);
  }

  void loadFile(String path) {
    state = state.copyWith(filePath: path, pageNumber: 1, zoom: 1.0);
  }

  void toggleMode() {
    // Emacsモードは無効化されているため、常にVimモードを維持
    // コードは残しておくが、実際には動作しない
    // state = state.copyWith(
    //   mode: state.mode == AppMode.emacs ? AppMode.vim : AppMode.emacs,
    // );
  }

  void setMode(AppMode mode) {
    state = state.copyWith(mode: mode);
  }
}
