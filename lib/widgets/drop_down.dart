import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
  DropDown({required this.title, required this.iconOpened, required this.iconClosed, required this.child});

  final Widget title;
  final Icon iconOpened;
  final Icon iconClosed;
  final Widget child;

  @override
  State createState() {
    return _DropDownState();
  }
}

class _DropDownState extends State<DropDown> {

  bool _isOpen = false;
  Duration _duration = const Duration(milliseconds: 300);
  double _size = 400;

  swapState() {
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red.shade200,
        ),
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: widget.title,
                  ),
                  IconButton(
                    onPressed: swapState,
                    icon: _isOpen ? widget.iconOpened : widget.iconClosed,
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.black54,
                  ),
                ),
              ),
              curve: Curves.easeInOut,
              duration: _duration,
              height: _isOpen ? _size : 0,
              child: Container(
                color: Colors.red.shade200,
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: SingleChildScrollView(
                    child: widget.child,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}