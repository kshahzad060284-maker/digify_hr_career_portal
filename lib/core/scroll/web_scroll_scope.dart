import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WebScrollScope extends StatefulWidget {
  const WebScrollScope({super.key, required this.child});

  final Widget child;

  @override
  State<WebScrollScope> createState() => _WebScrollScopeState();
}

class _WebScrollScopeState extends State<WebScrollScope> {
  final FocusNode _rootFocusNode = FocusNode(debugLabel: 'WebScrollFocus');

  @override
  void initState() {
    super.initState();
    HardwareKeyboard.instance.addHandler(_onKeyEvent);
  }

  @override
  void dispose() {
    HardwareKeyboard.instance.removeHandler(_onKeyEvent);
    _rootFocusNode.dispose();
    super.dispose();
  }

  bool get _isEditableFocused {
    final focusContext = primaryFocus?.context;
    if (focusContext == null) return false;
    return focusContext.findAncestorWidgetOfExactType<EditableText>() != null;
  }

  bool get _hasModifierKeys {
    final keyboard = HardwareKeyboard.instance;
    return keyboard.isShiftPressed ||
        keyboard.isControlPressed ||
        keyboard.isAltPressed ||
        keyboard.isMetaPressed;
  }

  ScrollIntent? _intentForKey(LogicalKeyboardKey key) {
    if (key == LogicalKeyboardKey.arrowDown) {
      return const ScrollIntent(
        direction: AxisDirection.down,
        type: ScrollIncrementType.line,
      );
    }
    if (key == LogicalKeyboardKey.arrowUp) {
      return const ScrollIntent(
        direction: AxisDirection.up,
        type: ScrollIncrementType.line,
      );
    }
    if (key == LogicalKeyboardKey.pageDown) {
      return const ScrollIntent(
        direction: AxisDirection.down,
        type: ScrollIncrementType.page,
      );
    }
    if (key == LogicalKeyboardKey.pageUp) {
      return const ScrollIntent(
        direction: AxisDirection.up,
        type: ScrollIncrementType.page,
      );
    }
    if (key == LogicalKeyboardKey.space) {
      return const ScrollIntent(
        direction: AxisDirection.down,
        type: ScrollIncrementType.page,
      );
    }
    return null;
  }

  ScrollPosition? _positionFromController(ScrollController? controller) {
    if (controller == null || !controller.hasClients) return null;
    return controller.positions.last;
  }

  ScrollPosition? _findDescendantScrollPosition(BuildContext context) {
    ScrollPosition? candidate;

    void visitor(Element element) {
      if (element is StatefulElement && element.state is ScrollableState) {
        final position = (element.state as ScrollableState).position;
        if (position.hasContentDimensions &&
            position.axis == Axis.vertical &&
            position.maxScrollExtent > 0) {
          candidate = position;
        }
      }
      element.visitChildren(visitor);
    }

    context.visitChildElements(visitor);
    return candidate;
  }

  ScrollPosition? _resolveScrollPosition() {
    final focusContext = primaryFocus?.context;

    if (focusContext != null) {
      final fromFocus = Scrollable.maybeOf(focusContext)?.position;
      if (fromFocus != null) return fromFocus;

      final fromPrimary = _positionFromController(
        PrimaryScrollController.maybeOf(focusContext),
      );
      if (fromPrimary != null) return fromPrimary;
    }

    final fromRootPrimary = _positionFromController(
      PrimaryScrollController.maybeOf(context),
    );
    if (fromRootPrimary != null) return fromRootPrimary;

    return _findDescendantScrollPosition(context);
  }

  double _calculateTargetOffset(ScrollPosition position, ScrollIntent intent) {
    final step = intent.type == ScrollIncrementType.page ? 350.0 : 80.0;

    if (intent.direction == AxisDirection.down) {
      return (position.pixels + step).clamp(0.0, position.maxScrollExtent);
    }
    return (position.pixels - step).clamp(0.0, position.maxScrollExtent);
  }

  bool _handleScrollIntent(ScrollIntent intent) {
    final position = _resolveScrollPosition();
    if (position == null || !position.hasContentDimensions) return false;

    position.animateTo(
      _calculateTargetOffset(position, intent),
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOutCubic,
    );
    return true;
  }

  bool _onKeyEvent(KeyEvent event) {
    if (!mounted) return false;
    if (event is! KeyDownEvent && event is! KeyRepeatEvent) return false;
    if (_isEditableFocused) return false;
    if (_hasModifierKeys) return false;

    final intent = _intentForKey(event.logicalKey);
    if (intent == null) return false;

    if (event.logicalKey == LogicalKeyboardKey.space) {
      final focusContext = primaryFocus?.context;
      if (focusContext != null &&
          Actions.maybeFind<ActivateIntent>(focusContext) != null) {
        return false;
      }
    }

    return _handleScrollIntent(intent);
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (_) {
        if (!FocusScope.of(context).hasFocus) {
          FocusScope.of(context).requestFocus(_rootFocusNode);
        }
      },
      child: Focus(
        focusNode: _rootFocusNode,
        autofocus: true,
        canRequestFocus: true,
        child: widget.child,
      ),
    );
  }
}
