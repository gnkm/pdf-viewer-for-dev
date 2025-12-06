enum AppMode {
  emacs,
  vim;

  static AppMode fromString(String value) {
    return AppMode.values.firstWhere(
      (e) => e.name == value,
      orElse: () => AppMode.vim,
    );
  }
}
