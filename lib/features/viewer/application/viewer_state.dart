import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:pdf_viewer_for_dev/core/config/app_mode.dart';

part 'viewer_state.freezed.dart';
part 'viewer_state.g.dart';

@freezed
abstract class ViewerState with _$ViewerState {
  const factory ViewerState({
    @Default(1) int pageNumber,
    @Default(1.0) double zoom,
    String? filePath,
    @Default(AppMode.emacs) AppMode mode,
    @Default(false) bool isSearchActive,
  }) = _ViewerState;
}

@riverpod
class ViewerNotifier extends _$ViewerNotifier {
// ...
  void toggleSearch() {
    state = state.copyWith(isSearchActive: !state.isSearchActive);
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
    state = state.copyWith(
      mode: state.mode == AppMode.emacs ? AppMode.vim : AppMode.emacs,
    );
  }

  void setMode(AppMode mode) {
    state = state.copyWith(mode: mode);
  }
}
