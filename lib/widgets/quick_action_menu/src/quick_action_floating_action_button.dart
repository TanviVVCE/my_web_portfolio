// import 'package:flutter/material.dart';
// import 'quick_action_icon.dart';

// class QuickActionMenuFloatingActionButton extends StatefulWidget {
//   final Function() open;
//   final Function() close;
//   final Function() onTap;
//   final bool isOpen;
//   final IconData icon;
//   final Color backgroundColor;

//   const QuickActionMenuFloatingActionButton({
//     required this.open,
//     required this.close,
//     required this.onTap,
//     required this.isOpen,
//     required this.icon,
//     required this.backgroundColor,
//     super.key,
//   });

//   @override
//   State<QuickActionMenuFloatingActionButton> createState() => _QuickActionMenuFloatingActionButtonState();
// }

// class _QuickActionMenuFloatingActionButtonState extends State<QuickActionMenuFloatingActionButton> {
//   final _duration = const Duration(milliseconds: 200);
//   var _isPressed = false;

//   _pressDown() {
//     setState(() {
//       _isPressed = true;
//     });
//   }

//   _pressUp() {
//     setState(() {
//       _isPressed = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTapDown: (_) => _pressDown(),
//       onTapUp: (_) => _pressUp(),
//       onTapCancel: () => _pressUp(),
//       onTap: () => widget.isOpen ? widget.close() : widget.onTap(),
//       onLongPress: () {
//         if (!widget.isOpen) {
//           widget.open();
//           _pressUp();
//         }
//       },
//       child: AnimatedScale(
//         scale: _isPressed || widget.isOpen ? 0.8 : 1,
//         duration: _duration,
//         child: Container(
//           decoration: const BoxDecoration(
//             boxShadow: [BoxShadow(blurRadius: 2, offset: Offset(0, 2), color: Colors.black26)],
//           ),
//           child: Stack(
//             children: [
//               QuickActionIcon(
//                 icon: Icon(Icons.close_rounded, color: widget.backgroundColor, size: 28),
//                 backgroundColor: Colors.white,
//               ),
//               AnimatedOpacity(
//                 opacity: widget.isOpen ? 0 : 1,
//                 duration: _duration,
//                 child: QuickActionIcon(
//                   icon: Icon(widget.icon, color: Colors.white, size: 28),
//                   backgroundColor: widget.backgroundColor,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'quick_action_icon.dart';

class QuickActionMenuFloatingActionButton extends StatefulWidget {
  final Function() open;
  final Function() close;
  final Function() onTap;
  final bool isOpen;
  final IconData icon;
  final Color backgroundColor;

  const QuickActionMenuFloatingActionButton({
    required this.open,
    required this.close,
    required this.onTap,
    required this.isOpen,
    required this.icon,
    required this.backgroundColor,
    super.key,
  });

  @override
  State<QuickActionMenuFloatingActionButton> createState() => _QuickActionMenuFloatingActionButtonState();
}

class _QuickActionMenuFloatingActionButtonState extends State<QuickActionMenuFloatingActionButton> {
  final _duration = const Duration(milliseconds: 200);
  var _isPressed = false;

  void _pressDown() {
    if (mounted) {
      setState(() {
        _isPressed = true;
      });
    }
  }

  void _pressUp() {
    if (mounted) {
      setState(() {
        _isPressed = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _pressDown(),
      onTapUp: (_) => _pressUp(),
      onTapCancel: () => _pressUp(),
      // CHANGED: Single tap opens menu, when open tap closes OR executes main action
      onTap: () {
        if (widget.isOpen) {
          widget.close();
        } else {
          widget.open(); // Open the radial menu on single tap
        }
      },
      // CHANGED: Long press now executes the main action (contact dialog)
      onLongPress: () {
        if (!widget.isOpen) {
          widget.onTap(); // Execute main action on long press
          _pressUp();
        }
      },
      child: AnimatedScale(
        scale: _isPressed || widget.isOpen ? 0.8 : 1,
        duration: _duration,
        child: Container(
          decoration: const BoxDecoration(
            // boxShadow: [BoxShadow(blurRadius: 2, offset: Offset(0, 2), color: Colors.black26)],
          ),
          child: Stack(
            children: [
              QuickActionIcon(
                icon: Icon(Icons.close_rounded, color: widget.backgroundColor, size: 28),
                backgroundColor: Colors.white,
              ),
              AnimatedOpacity(
                opacity: widget.isOpen ? 0 : 1,
                duration: _duration,
                child: QuickActionIcon(
                  icon: Icon(widget.icon, color: Colors.white, size: 28),
                  backgroundColor: widget.backgroundColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
