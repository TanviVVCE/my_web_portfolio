import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'quick_action.dart';
import 'quick_action_button_extended.dart';
import 'quick_action_floating_action_button.dart';

class QuickActionMenuExtended extends StatefulWidget {
  final Function() onTap;
  final IconData icon;
  final Color backgroundColor;
  final Widget child;
  final List<QuickAction> actions;

  const QuickActionMenuExtended({
    required this.onTap,
    required this.icon,
    required this.backgroundColor,
    required this.child,
    required this.actions,
    super.key,
  }) : assert(actions.length == 5, 'actions must have 5 items');

  @override
  State<QuickActionMenuExtended> createState() => _QuickActionMenuExtendedState();
}

class _QuickActionMenuExtendedState extends State<QuickActionMenuExtended> {
  var _isOpen = false;

  _open() {
    setState(() {
      HapticFeedback.lightImpact();
      _isOpen = true;
    });
  }

  _close() {
    setState(() {
      HapticFeedback.lightImpact();
      _isOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        widget.child,
        IgnorePointer(
          ignoring: !_isOpen,
          child: AnimatedOpacity(
            opacity: _isOpen ? 1 : 0,
            duration: const Duration(milliseconds: 150),
            child: GestureDetector(
              onTap: _close,
              child: Container(color: Colors.black.withOpacity(0.4)),
            ),
          ),
        ),
        ...widget.actions.map(
          (action) => QuickActionButtonExtended(
            action,
            isOpen: _isOpen,
            index: widget.actions.indexOf(action),
            totalActions: widget.actions.length,
            close: _close,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0).copyWith(bottom: MediaQuery.of(context).padding.bottom + 16),
          child: QuickActionMenuFloatingActionButton(
            backgroundColor: widget.backgroundColor,
            icon: widget.icon,
            open: _open,
            close: _close,
            isOpen: _isOpen,
            onTap: widget.onTap,
          ),
        ),
      ],
    );
  }
}
