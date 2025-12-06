import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:pdf_viewer_for_dev/core/config/app_mode.dart';
import 'package:pdf_viewer_for_dev/core/input/input_models.dart';
import 'package:pdf_viewer_for_dev/core/input/input_providers.dart';
import 'package:pdf_viewer_for_dev/core/input/viewer_action.dart';
import 'package:pdf_viewer_for_dev/features/viewer/application/viewer_state.dart';

class PdfViewerPage extends ConsumerStatefulWidget {
  const PdfViewerPage({super.key});

  @override
  ConsumerState<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends ConsumerState<PdfViewerPage> {
  final PdfViewerController _controller = PdfViewerController();
  // Removed: late final PdfTextSearcher _textSearcher;
  
  // ggキーシーケンス検出用
  bool _waitingForSecondG = false;
  Timer? _ggSequenceTimer;

  @override
  void initState() {
    super.initState();
    // Removed: _textSearcher = PdfTextSearcher(_controller);
  }
  
  @override
  void dispose() {
    _ggSequenceTimer?.cancel();
    super.dispose();
  }
  
  void _resetGgSequence() {
    _waitingForSecondG = false;
    _ggSequenceTimer?.cancel();
    _ggSequenceTimer = null;
  }
  
  void _handleGKey() {
    if (_waitingForSecondG) {
      // 2回目のgキーが押された -> ggシーケンス完了
      _resetGgSequence();
      _handleAction(ViewerAction.firstPage);
    } else {
      // 1回目のgキーが押された -> 2回目を待つ
      _waitingForSecondG = true;
      _ggSequenceTimer = Timer(const Duration(milliseconds: 500), () {
        // タイムアウトしたら状態をリセット
        if (mounted) {
          setState(() {
            _waitingForSecondG = false;
          });
        }
      });
    }
  }

  Future<void> _pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (result != null && result.files.single.path != null) {
        ref.read(viewerProvider.notifier).loadFile(result.files.single.path!);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error opening file: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(viewerProvider);
    final keyService = ref.watch(keyBindingServiceProvider);

    ref.listen(viewerProvider, (previous, next) {
      if (previous?.pageNumber != next.pageNumber) {
         if (_controller.isReady && _controller.pageNumber != next.pageNumber) {
             _controller.goToPage(pageNumber: next.pageNumber);
         }
      }
      // ズーム値が変更された場合、PdfViewerControllerに反映
      if (previous?.zoom != next.zoom && _controller.isReady) {
        // 現在の中心位置をズームの中心として使用
        final centerPosition = _controller.centerPosition;
        _controller.setZoom(centerPosition, next.zoom);
      }
    });

    if (state.filePath == null) {
       return Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("No PDF opened"),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _pickFile, 
                child: const Text("Open File"),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          Focus(
            autofocus: true,
            onKeyEvent: (node, event) {
              if (state.isSearchActive) return KeyEventResult.ignored;

              if (event is KeyDownEvent) {
                 final input = KeyInput(
                   event.physicalKey,
                   isControl: HardwareKeyboard.instance.isControlPressed,
                   isMeta: HardwareKeyboard.instance.isMetaPressed,
                   isAlt: HardwareKeyboard.instance.isAltPressed,
                   isShift: HardwareKeyboard.instance.isShiftPressed,
                 );
                 
                 // Vimモードでggシーケンス検出（修飾キーなしのgキーのみ）
                 if (state.mode == AppMode.vim &&
                     event.physicalKey == PhysicalKeyboardKey.keyG &&
                     !HardwareKeyboard.instance.isControlPressed &&
                     !HardwareKeyboard.instance.isMetaPressed &&
                     !HardwareKeyboard.instance.isAltPressed &&
                     !HardwareKeyboard.instance.isShiftPressed) {
                   _handleGKey();
                   return KeyEventResult.handled;
                 }
                 
                 // 他のキーが押されたらggシーケンスをリセット
                 if (_waitingForSecondG) {
                   _resetGgSequence();
                 }
                 
                 final action = keyService.getAction(input, state.mode);
                 if (action != null) {
                   _handleAction(action);
                   return KeyEventResult.handled;
                 }
              }
              return KeyEventResult.ignored;
            },
            child: PdfViewer.file(
              state.filePath!,
              controller: _controller,
              params: PdfViewerParams(
                onPageChanged: (page) {
                  if (page != null) {
                    ref.read(viewerProvider.notifier).setPage(page);
                  }
                },
              ),
            ),
          ),
          if (state.isSearchActive)
            Positioned(
              top: 0,
              right: 20,
              width: 300,
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.search),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          autofocus: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search...',
                          ),
                          onSubmitted: (value) {
                             if (value.isNotEmpty) {
                               // Simple search attempt if API allows
                               // If not, just show message "Search Logic Pending"
                               ScaffoldMessenger.of(context).showSnackBar(
                                 SnackBar(content: Text("Search logic implementation disabled due to API mismatch. Please update pdfrx.")),
                               );
                             }
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => ref.read(viewerProvider.notifier).toggleSearch(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        height: 48,
        child: Row(
          children: [
            const SizedBox(width: 16),
            Text("Page: ${state.pageNumber} / ${_controller.isReady ? _controller.pageCount : '?'}"),
            const SizedBox(width: 16),
            Text("Zoom: ${(state.zoom * 100).toInt()}%"),
            const Spacer(),
            InkWell(
              onTap: () => ref.read(viewerProvider.notifier).toggleMode(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Text(
                  "Mode: ${state.mode.name.toUpperCase()}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }

  void _handleAction(ViewerAction action) {
    final notifier = ref.read(viewerProvider.notifier);
    switch (action) {
      case ViewerAction.openFile:
        _pickFile();
        break;
      case ViewerAction.nextPage:
        notifier.setPage(ref.read(viewerProvider).pageNumber + 1);
        break;
      case ViewerAction.previousPage:
        notifier.setPage(ref.read(viewerProvider).pageNumber - 1);
        break;
      case ViewerAction.firstPage:
        notifier.setPage(1);
        break;
      case ViewerAction.lastPage:
        if (_controller.isReady) {
           notifier.setPage(_controller.pageCount);
        }
        break;
      case ViewerAction.zoomIn:
        notifier.setZoom(ref.read(viewerProvider).zoom + 0.1);
        break;
      case ViewerAction.zoomOut:
        notifier.setZoom(ref.read(viewerProvider).zoom - 0.1);
        break;
      case ViewerAction.zoomReset:
        notifier.setZoom(1.0);
        break;
      case ViewerAction.search:
        notifier.toggleSearch();
        break;
      case ViewerAction.toggleMode:
        notifier.toggleMode();
        break;
      case ViewerAction.fitToScreen:
        // Treat as "Actual Size" or "Default" for now
        notifier.setZoom(1.0);
        break;
        
      case ViewerAction.jumpPage10: _jumpToPercent(0.1); break;
      case ViewerAction.jumpPage20: _jumpToPercent(0.2); break;
      case ViewerAction.jumpPage30: _jumpToPercent(0.3); break;
      case ViewerAction.jumpPage40: _jumpToPercent(0.4); break;
      case ViewerAction.jumpPage50: _jumpToPercent(0.5); break;
      case ViewerAction.jumpPage60: _jumpToPercent(0.6); break;
      case ViewerAction.jumpPage70: _jumpToPercent(0.7); break;
      case ViewerAction.jumpPage80: _jumpToPercent(0.8); break;
      case ViewerAction.jumpPage90: _jumpToPercent(0.9); break;
    }
  }

  void _jumpToPercent(double percent) {
    if (_controller.isReady) {
      final target = (_controller.pageCount * percent).floor();
      final page = target < 1 ? 1 : target;
      ref.read(viewerProvider.notifier).setPage(page);
    }
  }
}
