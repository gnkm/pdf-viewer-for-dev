import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf_viewer_for_dev/core/config/config_model.dart';
import 'package:pdf_viewer_for_dev/core/config/config_service.dart';
import 'package:pdf_viewer_for_dev/features/viewer/application/viewer_state.dart';
import 'package:pdf_viewer_for_dev/features/viewer/presentation/pdf_viewer_page.dart';
import 'package:window_manager/window_manager.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  // Load Config
  final config = await ConfigService.load();

  // Handle CLI Args
  String? cliFile;
  if (args.isNotEmpty) {
    // Basic argument handling: assume first arg is file path
    final path = args.first;
    if (File(path).existsSync()) {
      cliFile = File(path).absolute.path;
    }
  }

  // Setup Window
  const WindowOptions windowOptions = WindowOptions(
    size: Size(1280, 800),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
    title: 'PDF Viewer for Developers',
  );

  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(
    ProviderScope(
      child: MyApp(config: config, initialFile: cliFile),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key, required this.config, this.initialFile});

  final ConfigModel config;
  final String? initialFile;

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> with WindowListener {
  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);

    // Initialize state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final notifier = ref.read(viewerProvider.notifier);
      notifier.setMode(widget.config.defaultMode);

      // Load last session if initialFile is null
      if (widget.initialFile != null) {
        notifier.loadFile(widget.initialFile!);
      } else if (widget.config.lastSession != null) {
        final session = widget.config.lastSession!;
        if (session.filePath != null && File(session.filePath!).existsSync()) {
          notifier.loadFile(session.filePath!);
          if (session.pageNumber != null) {
            notifier.setPage(session.pageNumber!);
          }
          if (session.zoom != null) {
            notifier.setZoom(session.zoom!);
          }
        }
      }
    });
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  void onWindowClose() {
    _saveState();
    super.onWindowClose();
  }

  Future<void> _saveState() async {
    final state = ref.read(viewerProvider);
    final newConfig = widget.config.copyWith(
      defaultMode: state.mode,
      lastSession: LastSession(
        filePath: state.filePath,
        pageNumber: state.pageNumber,
        zoom: state.zoom,
      ),
    );
    await ConfigService.save(newConfig);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'vfd',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: _getThemeMode(widget.config.theme),
      home: const PdfViewerPage(),
    );
  }

  ThemeMode _getThemeMode(String theme) {
    switch (theme) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }
}
