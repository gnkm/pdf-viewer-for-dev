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

  // ggキーシーケンス検出用
  bool _waitingForSecondG = false;
  Timer? _ggSequenceTimer;

  // :eキーシーケンス検出用（Vimモード）
  bool _waitingForColonE = false;
  Timer? _colonSequenceTimer;

  @override
  void dispose() {
    _ggSequenceTimer?.cancel();
    _colonSequenceTimer?.cancel();
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

  void _resetColonSequence() {
    _waitingForColonE = false;
    _colonSequenceTimer?.cancel();
    _colonSequenceTimer = null;
  }

  void _handleColonKey() {
    // :が押された -> eを待つ
    _waitingForColonE = true;
    _colonSequenceTimer = Timer(const Duration(milliseconds: 2000), () {
      // タイムアウトしたら状態をリセット
      if (mounted) {
        setState(() {
          _waitingForColonE = false;
        });
      }
    });
  }

  void _handleEKey() {
    if (_waitingForColonE) {
      // :eシーケンス完了 -> ファイルを開く
      _resetColonSequence();
      _pickFile();
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
            content: Text('ファイルを開けませんでした: $e'),
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

    // 共通のキーイベントハンドラー（Cmd + O など）
    KeyEventResult handleKeyEvent(FocusNode node, KeyEvent event) {
      if (event is KeyDownEvent) {
        final isControl = HardwareKeyboard.instance.isControlPressed;
        final isMeta = HardwareKeyboard.instance.isMetaPressed;
        final isAlt = HardwareKeyboard.instance.isAltPressed;
        final isShift = HardwareKeyboard.instance.isShiftPressed;

        // 修飾キー自体は無視
        if (event.physicalKey == PhysicalKeyboardKey.controlLeft ||
            event.physicalKey == PhysicalKeyboardKey.controlRight ||
            event.physicalKey == PhysicalKeyboardKey.shiftLeft ||
            event.physicalKey == PhysicalKeyboardKey.shiftRight ||
            event.physicalKey == PhysicalKeyboardKey.altLeft ||
            event.physicalKey == PhysicalKeyboardKey.altRight ||
            event.physicalKey == PhysicalKeyboardKey.metaLeft ||
            event.physicalKey == PhysicalKeyboardKey.metaRight) {
          return KeyEventResult.ignored;
        }

        final input = KeyInput(
          event.physicalKey,
          isControl: isControl,
          isMeta: isMeta,
          isAlt: isAlt,
          isShift: isShift,
        );

        final action = keyService.getAction(input, state.mode);
        if (action != null) {
          _handleAction(action);
          return KeyEventResult.handled;
        }
      }
      return KeyEventResult.ignored;
    }

    if (state.filePath == null) {
      return Scaffold(
        body: Focus(
          autofocus: true,
          onKeyEvent: handleKeyEvent,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('PDFファイルが開かれていません'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _pickFile,
                  child: const Text('ファイルを開く'),
                ),
                const SizedBox(height: 8),
                Text(
                  'Cmd + O でもファイルを開けます',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      );
    }

    // PDFビューアー用のキーイベントハンドラー（Vimシーケンスなど追加）
    KeyEventResult handlePdfViewerKeyEvent(FocusNode node, KeyEvent event) {
      if (state.isSearchActive) return KeyEventResult.ignored;

      if (event is KeyDownEvent) {
        final isControl = HardwareKeyboard.instance.isControlPressed;
        final isMeta = HardwareKeyboard.instance.isMetaPressed;
        final isAlt = HardwareKeyboard.instance.isAltPressed;
        final isShift = HardwareKeyboard.instance.isShiftPressed;

        // 修飾キー自体は無視
        if (event.physicalKey == PhysicalKeyboardKey.controlLeft ||
            event.physicalKey == PhysicalKeyboardKey.controlRight ||
            event.physicalKey == PhysicalKeyboardKey.shiftLeft ||
            event.physicalKey == PhysicalKeyboardKey.shiftRight ||
            event.physicalKey == PhysicalKeyboardKey.altLeft ||
            event.physicalKey == PhysicalKeyboardKey.altRight ||
            event.physicalKey == PhysicalKeyboardKey.metaLeft ||
            event.physicalKey == PhysicalKeyboardKey.metaRight) {
          return KeyEventResult.ignored;
        }

        // Vimモードで:eシーケンス検出
        if (state.mode == AppMode.vim) {
          // :が押された場合（Shift + ;）
          if (event.physicalKey == PhysicalKeyboardKey.semicolon &&
              !isControl &&
              !isMeta &&
              !isAlt &&
              isShift) {
            _handleColonKey();
            return KeyEventResult.handled;
          }
          // eが押された場合（:待機中、修飾キーなし）
          if (event.physicalKey == PhysicalKeyboardKey.keyE &&
              !isControl &&
              !isMeta &&
              !isAlt &&
              !isShift) {
            if (_waitingForColonE) {
              _handleEKey();
              return KeyEventResult.handled;
            }
          }
          // Escキーで:シーケンスをキャンセル
          if (event.physicalKey == PhysicalKeyboardKey.escape &&
              _waitingForColonE) {
            _resetColonSequence();
            return KeyEventResult.handled;
          }
        }

        // Vimモードでggシーケンス検出（修飾キーなしのgキーのみ）
        if (state.mode == AppMode.vim &&
            event.physicalKey == PhysicalKeyboardKey.keyG &&
            !isControl &&
            !isMeta &&
            !isAlt &&
            !isShift) {
          _handleGKey();
          return KeyEventResult.handled;
        }

        // 他のキーが押されたらシーケンスをリセット
        if (_waitingForSecondG) {
          _resetGgSequence();
        }
        if (_waitingForColonE &&
            !(event.physicalKey == PhysicalKeyboardKey.keyE &&
                !isControl &&
                !isMeta &&
                !isAlt &&
                !isShift) &&
            !(event.physicalKey == PhysicalKeyboardKey.escape)) {
          _resetColonSequence();
        }

        // 共通のキーイベント処理
        return handleKeyEvent(node, event);
      }
      return KeyEventResult.ignored;
    }

    return Scaffold(
      body: Stack(
        children: [
          Focus(
            autofocus: true,
            onKeyEvent: handlePdfViewerKeyEvent,
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
                            hintText: '検索...',
                          ),
                          onSubmitted: (value) {
                            if (value.isNotEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('検索機能は現在実装中です。')),
                              );
                            }
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () =>
                            ref.read(viewerProvider.notifier).toggleSearch(),
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
            Text(
              'ページ: ${state.pageNumber} / ${_controller.isReady ? _controller.pageCount : '?'}',
            ),
            const SizedBox(width: 16),
            Text('ズーム: ${(state.zoom * 100).toInt()}%'),
            const Spacer(),
            InkWell(
              onTap: () => ref.read(viewerProvider.notifier).toggleMode(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                child: Text(
                  'モード: ${state.mode.name.toUpperCase()}',
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
        notifier.setZoom(1.0);
        break;
      case ViewerAction.jumpPage10:
        _jumpToPercent(0.1);
        break;
      case ViewerAction.jumpPage20:
        _jumpToPercent(0.2);
        break;
      case ViewerAction.jumpPage30:
        _jumpToPercent(0.3);
        break;
      case ViewerAction.jumpPage40:
        _jumpToPercent(0.4);
        break;
      case ViewerAction.jumpPage50:
        _jumpToPercent(0.5);
        break;
      case ViewerAction.jumpPage60:
        _jumpToPercent(0.6);
        break;
      case ViewerAction.jumpPage70:
        _jumpToPercent(0.7);
        break;
      case ViewerAction.jumpPage80:
        _jumpToPercent(0.8);
        break;
      case ViewerAction.jumpPage90:
        _jumpToPercent(0.9);
        break;
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
