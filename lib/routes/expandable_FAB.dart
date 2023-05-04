import 'package:flutter/material.dart';

class ExpandableFab extends StatefulWidget {
  final List<Widget> children;
  final IconData icon;

  ExpandableFab({required this.children, required this.icon});

  @override
  _ExpandableFabState createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animationIcon;
  late Animation<double> _animationButton;

  bool _isOpen = false;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });

    _animationIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    _animationButton = Tween<double>(begin: 56.0, end: 56.0 + (56.0 * widget.children.length))
        .animate(CurvedAnimation(
            parent: _animationController,
            curve: Curves.linearToEaseOut));

    _isOpen = false;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _isOpen = !_isOpen;
      if (_isOpen) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  Widget _buildSubButton(int index) {
    final double bottom = _animationButton.value - (index * 56.0);

    return Positioned(
    
      bottom: bottom,
      right: 16.0,
      child: ScaleTransition(
        scale: _animationIcon,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            onPressed: () {},
            child: widget.children[index],
          
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> subButtons = [];
    for (int i = 0; i < widget.children.length; i++) {
      subButtons.add(_buildSubButton(i));
    }

    return Container(
      
      margin: EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ...subButtons.reversed,
          Transform.rotate(
            angle: _animationIcon.value * 0.5 * 3.14,
            child: FloatingActionButton(
              onPressed: _toggle,
              backgroundColor: Color.fromARGB(255, 21, 37, 117),
              child: AnimatedIcon(
                icon: AnimatedIcons.add_event,
                color: Color.fromARGB(255, 172, 12, 12),
                progress: _animationIcon,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
